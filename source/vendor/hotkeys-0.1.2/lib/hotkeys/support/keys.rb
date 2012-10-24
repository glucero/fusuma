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

load_bridge_support_file File.dirname(__FILE__) + '/bridgesupport/Events.bridgesupport'

class HotKeys
  module Support
    class Keys

      # Returns an array with [keyCode, keyModifier]
      #
      # Examples: 
      #   Keys.parse("A")
      #   => [0, 0]
      #   Keys.parse("A+COMMAND")
      #   => [0, 256]
      #   Keys.parse("A+COMMAND+OPTION")
      #   => [0, 2304]
      #   Keys.parse("B+COMMAND+OPTION+SHIFT")
      #   => [11, 2816]
      #
      # Note: A is literally 0 on the virtual keyboard, these virtual mappings are dumb-founding
      #   Why they couldn't simply be ASCII or Unicode; what the sh-t steve?
      #
      def self.parse(keyString)
        keyModifiers = HotKeys::Support::Keys::Mappings.select {|key, value| key =~ /Key$/ }
        keyCodes     = HotKeys::Support::Keys::Mappings.select {|key, value| !(key =~ /Key$/) }

        keyModifiersRegexPart = keyModifiers.map {|key, value| key.gsub(/Key$/, "")}.sort_by {|x| x.length}.reverse.join("|")
        keyModifiers          = keyModifiers.map {|key, value| {key.gsub(/Key$/, "").to_s.downcase => value}}.inject({}) {|retval,hash| retval.merge(hash) }
        keyCodesRegexPart     = keyCodes.map     {|key, value| key                 }.sort_by {|x| x.length}.reverse.join("|")
        keyCodes              = keyCodes.map     {|key, value| {key.to_s.downcase => value}}.inject({}) {|retval,hash| retval.merge(hash) }

        keyRegexString = "(#{keyCodesRegexPart})[\+]?(#{keyModifiersRegexPart})?[\+]?(#{keyModifiersRegexPart})?[\+]?(#{keyModifiersRegexPart})?"
        matchData = Regexp.new(keyRegexString, true).match(keyString)

        if matchData && matchData[1] && keyCodes[matchData[1].downcase]
          [
            keyCodes[matchData[1].downcase],
            ((matchData[2]) ? keyModifiers[matchData[2].downcase] : 0) +
            ((matchData[3]) ? keyModifiers[matchData[3].downcase] : 0) +
            ((matchData[4]) ? keyModifiers[matchData[4].downcase] : 0)
          ]
        else
          raise "Cannot parse hotkey #{keyString}. /#{keyRegexString}/i"
        end
      end

      # This doesn't map all the virtual keyboard keys, just the "useful" ones, 
      # submit an issue on github if you think it should include more
      Mappings = {
        :ControlKey      => ControlKey,
        :OptionKey       => OptionKey,
        :CommandKey      => CmdKey,
        :ShiftKey        => ShiftKey,
        :RightOptionKey  => RightOptionKey,
        :RightControlKey => RightControlKey,
        :RightShiftKey   => RightShiftKey,
        :Num0            => KVK_ANSI_0,
        :Num1            => KVK_ANSI_1,
        :Num2            => KVK_ANSI_2,
        :Num3            => KVK_ANSI_3,
        :Num4            => KVK_ANSI_4,
        :Num5            => KVK_ANSI_5,
        :Num6            => KVK_ANSI_6,
        :Num7            => KVK_ANSI_7,
        :Num8            => KVK_ANSI_8,
        :Num9            => KVK_ANSI_9,
        :Keypad0         => KVK_ANSI_Keypad0,
        :Keypad1         => KVK_ANSI_Keypad1,
        :Keypad2         => KVK_ANSI_Keypad2,
        :Keypad3         => KVK_ANSI_Keypad3,
        :Keypad4         => KVK_ANSI_Keypad4,
        :Keypad5         => KVK_ANSI_Keypad5,
        :Keypad6         => KVK_ANSI_Keypad6,
        :Keypad7         => KVK_ANSI_Keypad7,
        :Keypad8         => KVK_ANSI_Keypad8,
        :Keypad9         => KVK_ANSI_Keypad9,
        :KeypadClear     => KVK_ANSI_KeypadClear,
        :KeypadDecimal   => KVK_ANSI_KeypadDecimal,
        :KeypadDivide    => KVK_ANSI_KeypadDivide,
        :KeypadEnter     => KVK_ANSI_KeypadEnter,
        :KeypadEquals    => KVK_ANSI_KeypadEquals,
        :KeypadMinus     => KVK_ANSI_KeypadMinus,
        :KeypadMultiply  => KVK_ANSI_KeypadMultiply,
        :KeypadPlus      => KVK_ANSI_KeypadPlus,
        :A               => KVK_ANSI_A,
        :B               => KVK_ANSI_B,
        :C               => KVK_ANSI_C,
        :D               => KVK_ANSI_D,
        :E               => KVK_ANSI_E,
        :F               => KVK_ANSI_F,
        :G               => KVK_ANSI_G,
        :H               => KVK_ANSI_H,
        :I               => KVK_ANSI_I,
        :J               => KVK_ANSI_J,
        :K               => KVK_ANSI_K,
        :L               => KVK_ANSI_L,
        :M               => KVK_ANSI_M,
        :N               => KVK_ANSI_N,
        :O               => KVK_ANSI_O,
        :P               => KVK_ANSI_P,
        :Q               => KVK_ANSI_Q,
        :R               => KVK_ANSI_R,
        :S               => KVK_ANSI_S,
        :T               => KVK_ANSI_T,
        :U               => KVK_ANSI_U,
        :V               => KVK_ANSI_V,
        :W               => KVK_ANSI_W,
        :X               => KVK_ANSI_X,
        :Y               => KVK_ANSI_Y,
        :Z               => KVK_ANSI_Z,
        :F1              => KVK_F1,
        :F2              => KVK_F2,
        :F3              => KVK_F3,
        :F4              => KVK_F4,
        :F5              => KVK_F5,
        :F6              => KVK_F6,
        :F7              => KVK_F7,
        :F8              => KVK_F8,
        :F9              => KVK_F9,
        :F10             => KVK_F10,
        :F11             => KVK_F11,
        :F12             => KVK_F12,
        :F13             => KVK_F13,
        :F14             => KVK_F14,
        :F15             => KVK_F15,
        :F16             => KVK_F16,
        :F17             => KVK_F17,
        :F18             => KVK_F18,
        :F19             => KVK_F19,
        :F20             => KVK_F20,
        :Space           => KVK_Space,
        :Tab             => KVK_Tab,
        :Return          => KVK_Return,
        :Minus           => KVK_ANSI_Minus,
        :Equal           => KVK_ANSI_Equal,
        :Backslash       => KVK_ANSI_Backslash,
        :Slash           => KVK_ANSI_Slash,
        :LeftBracket     => KVK_ANSI_LeftBracket,
        :RightBracket    => KVK_ANSI_RightBracket,
        :Comma           => KVK_ANSI_Comma,
        :Period          => KVK_ANSI_Period,
        :Semicolon       => KVK_ANSI_Semicolon,
        :Quote           => KVK_ANSI_Quote,
        :Function        => KVK_Function,
        :Home            => KVK_Home,
        :PageUp          => KVK_PageUp,
        :PageDown        => KVK_PageDown,
        :End             => KVK_End,
        :ForwardDelete   => KVK_ForwardDelete,
        :Delete          => KVK_Delete,
        :CapsLock        => KVK_CapsLock,
        :LeftArrow       => KVK_LeftArrow,
        :UpArrow         => KVK_UpArrow,
        :DownArrow       => KVK_DownArrow,
        :RightArrow      => KVK_RightArrow,
        :Escape          => KVK_Escape,
        :Grave           => KVK_ANSI_Grave,
        :Help            => KVK_Help,
        :VolumeDown      => KVK_VolumeDown,
        :VolumeUp        => KVK_VolumeUp,
        :Mute            => KVK_Mute,
        :KeyDown         => KeyDown,
        :KeyUp           => KeyUp,
        :MouseDown       => MouseDown,
        :MouseUp         => MouseUp
      }
    end
  end
end