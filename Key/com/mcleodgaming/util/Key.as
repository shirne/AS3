package com.mcleodgaming.util
{	
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.display.DisplayObject;
	
	/**
	 * Tool for AS3 to enable AS2-styled keyboard event behavior. Simply call Key.init() to initialize the class, and Key.beginCapture()/Key.endCapture() to start and end the keyboard event listeners respectively. Also included in this class are also all of the Flash key code values so you don't have to look them up.
	 */
	public class Key
	{
		private static var m_pressedKeys:Array;
		private static var m_disabled:Boolean;
		private static var m_initialized:Boolean = false;
		private static var m_targetObject:DisplayObject;
		private static var m_captureStarted:Boolean;
		
		/**
		 * Initializes the Key class
		 */
		public static function init():void
		{
			m_pressedKeys = new Array();
			m_disabled = false;
			m_initialized = true;
			m_targetObject = null;
			m_captureStarted = false;
		
			trace("Key class initialized");
		}
		
		/**
		 * Starts capturing keyboard inputs within the supplied DisplayObject.
		 * @param	targetObject The object which will trigger the events when it is in focus.
		 */
		public static function beginCapture(targetObject:DisplayObject):void
		{
			if (!m_initialized)
			{
				trace("Error, Key.init() was never called");
				return;
			}
			if (targetObject != null)
			{
				if (m_captureStarted)
				{
					endCapture();
				}
				m_targetObject = targetObject;
				m_targetObject.addEventListener(KeyboardEvent.KEY_DOWN, Key.keyDown);
				m_targetObject.addEventListener(KeyboardEvent.KEY_UP, Key.keyUp);
				m_targetObject.addEventListener(Event.DEACTIVATE,Key.resetKeys);
				m_targetObject.addEventListener(Event.ACTIVATE, Key.restartKeys);
				m_captureStarted = true;
				trace("Key class activated");
			} else
			{
				trace("Error, null target passed to Key.as");
			}
		}
		
		/**
		 * Stops capturing keyboard inputs
		 */
		public static function endCapture():void
		{
			if (!m_initialized)
			{
				trace("Error, Key.init() was never called");
				return;
			}
			if (m_captureStarted)
			{
				m_targetObject.removeEventListener(KeyboardEvent.KEY_DOWN, Key.keyDown);
				m_targetObject.removeEventListener(KeyboardEvent.KEY_UP, Key.keyUp);
				m_targetObject.removeEventListener(Event.DEACTIVATE,Key.resetKeys);
				m_targetObject.removeEventListener(Event.ACTIVATE, Key.restartKeys);
				m_targetObject = null;
				m_captureStarted = false;
				resetKeys(null);
				trace("Key class deactivated");
			} else
			{
				trace("Warning, attempt to end capture when it was never started");
			}
		}
		
		/**
		 * Called when a key is pressed
		 * @param	e
		 */
		private static function keyDown(e:KeyboardEvent):void
		{
			if (!m_disabled)
				m_pressedKeys[e.keyCode] = true;
		}
		
		/**
		 * Called when a key is released
		 * @param	e
		 */
		private static function keyUp(e:KeyboardEvent):void
		{
			if (!m_disabled)
				m_pressedKeys[e.keyCode] = false;
		}
		
		/**
		 * Forces all keyboard data to false. This is used when the current object listening for key presses loses focus, and prevents keys from getting "stuck".
		 * @param	e
		 */
		private static function resetKeys(e:Event = null):void
		{
			if (!m_initialized)
			{
				trace("Error, Key.init() was never called");
				return;
			}
			//Sets all key states to false
			for (var i:* in m_pressedKeys)
				m_pressedKeys[i] = false;
			m_disabled = true;
		}
		
		/**
		 * Removes the disabled flag so that the object listening for key presses can receive events again once it regains focus
		 * @param	e
		 */
		private static function restartKeys(e:Event = null):void
		{
			m_disabled = false;
		}
		
		/**
		 * Returns the state of a key given its key code.
		 * @param	keyCode The the supplied key code.
		 * @return True if the key is pressed, false otherwise.
		 */
		public static function isDown(keyCode:Number):Boolean
		{
			return Boolean(!m_disabled && m_initialized && m_pressedKeys[keyCode] != undefined && m_pressedKeys[keyCode] != null && m_pressedKeys[keyCode] == true);
		}
		
		//Key Code values
		public static const A:int = 65;
		public static const B:int = 66;
		public static const C:int = 67;
		public static const D:int = 68;
		public static const E:int = 69;
		public static const F:int = 70;
		public static const G:int = 71;
		public static const H:int = 72;
		public static const I:int = 73;
		public static const J:int = 74;
		public static const K:int = 75;
		public static const L:int = 76;
		public static const M:int = 77;
		public static const N:int = 78;
		public static const O:int = 79;
		public static const P:int = 80;
		public static const Q:int = 81;
		public static const R:int = 82;
		public static const S:int = 83;
		public static const T:int = 84;
		public static const U:int = 85;
		public static const V:int = 86;
		public static const W:int = 87;
		public static const X:int = 88;
		public static const Y:int = 89;
		public static const Z:int = 90;
		
		//NUMBERS
		public static const ZERO:int = 48;
		public static const ONE:int = 49;
		public static const TWO:int = 50;
		public static const THREE:int = 51;
		public static const FOUR:int = 52;
		public static const FIVE:int = 53;
		public static const SIX:int = 54;
		public static const SEVEN:int = 55;
		public static const EIGHT:int = 56;
		public static const NINE:int = 57;
		
		//NUMPAD
		public static const NUMPAD_0:int = 96;
		public static const NUMPAD_1:int = 97;
		public static const NUMPAD_2:int = 98;
		public static const NUMPAD_3:int = 99;
		public static const NUMPAD_4:int = 100;
		public static const NUMPAD_5:int = 101;
		public static const NUMPAD_6:int = 102;
		public static const NUMPAD_7:int = 103;
		public static const NUMPAD_8:int = 104;
		public static const NUMPAD_9:int = 105;
		public static const NUMPAD_MULTIPLY:int = 106;
		public static const NUMPAD_ADD:int = 107;
		public static const NUMPAD_ENTER:int = 108;
		public static const NUMPAD_SUBTRACT:int = 109;
		public static const NUMPAD_DECIMAL:int = 110;
		public static const NUMPAD_DIVIDE:int = 111;
		
		//FUNCTION KEYS
		public static const F1:int = 112;
		public static const F2:int = 113;
		public static const F3:int = 114;
		public static const F4:int = 115;
		public static const F5:int = 116;
		public static const F6:int = 117;
		public static const F7:int = 118;
		public static const F8:int = 119;
		public static const F9:int = 120;
		public static const F10:int = 121;
		public static const F11:int = 122;
		public static const F12:int = 123;
		public static const F13:int = 124;
		public static const F14:int = 125;
		public static const F15:int = 126;
		
		//SYMBOLS
		public static const COLON:int = 186;
		public static const EQUALS:int = 187;
		public static const UNDERSCORE:int = 189;
		public static const QUESTION_MARK:int = 191;
		public static const TILDE:int = 192;
		public static const OPEN_BRACKET:int = 219;
		public static const BACKWARD_SLASH:int = 220;
		public static const CLOSED_BRACKET:int = 221;
		public static const QUOTES:int = 222;
		public static const LESS_THAN:int = 188;
		public static const GREATER_THAN:int = 190;
		
		//OTHER KEYS		
		public static const BACKSPACE:int = 8;
		public static const TAB:int = 9;
		public static const CLEAR:int = 12;
		public static const ENTER:int = 13;
		public static const SHIFT:int = 16;
		public static const CONTROL:int = 17;
		public static const ALT:int = 18;
		public static const CAPS_LOCK:int = 20;
		public static const ESC:int = 27;
		public static const SPACEBAR:int = 32;
		public static const PAGE_UP:int = 33;
		public static const PAGE_DOWN:int = 34;
		public static const END:int = 35;
		public static const HOME:int = 36;
		public static const LEFT:int = 37;
		public static const UP:int = 38;
		public static const RIGHT:int = 39;
		public static const DOWN:int = 40;
		public static const INSERT:int = 45;
		public static const DELETE:int = 46;
		public static const HELP:int = 47;
		public static const NUM_LOCK:int = 144;
	}
}