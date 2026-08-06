package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindowModel;
   
   public class WindowMessage extends WindowEvent
   {
      private static const WINDOW_EVENT_MESSAGE:String = "WE_MESSAGE";
      
      private static const UnknownConstFromWindowMessage_Array_1:Array = [];
      
      public var message:String;
      
      public function WindowMessage()
      {
         super();
         _type = "WE_MESSAGE";
      }
      
      public static function allocate(param1:String, param2:IWindowModel, param3:IWindowModel, param4:Boolean = false) : WindowEvent
      {
         var _loc5_:WindowMessage = UnknownConstFromWindowMessage_Array_1.length > 0 ? UnknownConstFromWindowMessage_Array_1.pop() : new WindowMessage();
         _loc5_.message = param1;
         _loc5_._window = param2;
         _loc5_._related = param3;
         _loc5_._cancelable = param4;
         _loc5_.UnknownVarFromWindowEvent_Boolean_1 = false;
         _loc5_.UnknownVarFromWindowEvent_Array_1 = UnknownConstFromWindowMessage_Array_1;
         return _loc5_;
      }
      
      override public function clone() : WindowEvent
      {
         return allocate(message,window,related,cancelable);
      }
      
      override public function toString() : String
      {
         return "WindowLinkEvent { type: " + _type + " message: " + message + " cancelable: " + _cancelable + " window: " + _window + " }";
      }
   }
}

