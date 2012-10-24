# Copyright (C) 2011 by Robert Lowe <rob[!]iblargz.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
unless RUBY_ENGINE =~ /macruby/
  raise NotImplementedError, "Hotkeys only runs on macruby! ;)"
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

framework 'AppKit'
framework 'Carbon'
framework 'Cocoa'
framework 'ScriptingBridge'

# required here, beause we subclass this sucker right away.
require File.dirname(__FILE__) + '/hotkeys/support/bundles/shortcut'

class HotKeys < Shortcut
  autoload :Version,       'hotkeys/version'
  autoload :Support,       'hotkeys/support'

  def initialize(delegation=nil)
    self.delegate = delegation || self
  end

  def hotkeyWasPressed(key)
    # Matching int
    configuration = @configurations.detect {|configuration| configuration[:key] == key }
    str = configuration[:str]

    # Sibling bindings
    configurations = @configurations.select {|config| config[:str] == str}

    # Run em
    configurations.each do |configuration|
      block = configuration[:block]
      if configuration[:bundle_identifier] == frontmost_bundler_identifier
          block.call
      elsif configuration[:bundle_identifier].nil?
          block.call
      end
    end if configurations
  end

  def addHotString(str, options = {}, &block)
    args = HotKeys::Support::Keys.parse(str)
    @configurations ||= []
    key = self.send(:"addShortcut:withKeyModifier", *args)
    @configurations << {
      :key => key.to_s,
      :str => str,
      :block => block,
      :bundle_identifier => options.delete(:bundle_identifier)
    }
  end

private

  def systemevents
    @systemevents ||= SBApplication.applicationWithBundleIdentifier("com.apple.systemevents")
  end

  def frontmost
    @frontmost = systemevents.processes.select {|process| process.frontmost == true }
    @frontmost.first
  end

  def frontmost_bundler_identifier
    frontmost.bundleIdentifier if frontmost
  end

end

