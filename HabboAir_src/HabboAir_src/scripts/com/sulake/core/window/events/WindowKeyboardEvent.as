package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindowModel;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   
   public class WindowKeyboardEvent extends WindowEvent
   {
      public static const UnknownConstFromWindowKeyboardEvent_String_1:String = "WKE_KEY_UP";
      
      public static const UnknownConstFromWindowKeyboardEvent_String_2:String = "WKE_KEY_DOWN";
      
      private static const UnknownConstFromWindowKeyboardEvent_Array_1:Array = [];
      
      private var UnknownVarFromWindowKeyboardEvent_KeyboardEvent_1:KeyboardEvent;
      
      public function WindowKeyboardEvent()
      {
         super();
      }
      
      public static function allocate(param1:String, param2:Event, param3:IWindowModel, param4:IWindowModel, param5:Boolean = false) : WindowKeyboardEvent
      {
         var _loc6_:WindowKeyboardEvent = UnknownConstFromWindowKeyboardEvent_Array_1.length > 0 ? UnknownConstFromWindowKeyboardEvent_Array_1.pop() : new WindowKeyboardEvent();
         _loc6_._type = param1;
         _loc6_.UnknownVarFromWindowKeyboardEvent_KeyboardEvent_1 = param2 as KeyboardEvent;
         _loc6_._window = param3;
         _loc6_._related = param4;
         _loc6_.UnknownVarFromWindowEvent_Boolean_1 = false;
         _loc6_._cancelable = param5;
         _loc6_.UnknownVarFromWindowEvent_Array_1 = UnknownConstFromWindowKeyboardEvent_Array_1;
         return _loc6_;
      }
      
      public function get charCode() : uint
      {
         return UnknownVarFromWindowKeyboardEvent_KeyboardEvent_1.charCode;
      }
      
      public function get keyCode() : uint
      {
         return UnknownVarFromWindowKeyboardEvent_KeyboardEvent_1.keyCode;
      }
      
      public function get keyLocation() : uint
      {
         return UnknownVarFromWindowKeyboardEvent_KeyboardEvent_1.keyLocation;
      }
      
      public function get altKey() : Boolean
      {
         return UnknownVarFromWindowKeyboardEvent_KeyboardEvent_1.altKey;
      }
      
      public function get shiftKey() : Boolean
      {
         return UnknownVarFromWindowKeyboardEvent_KeyboardEvent_1.shiftKey;
      }
      
      public function get ctrlKey() : Boolean
      {
         return UnknownVarFromWindowKeyboardEvent_KeyboardEvent_1.ctrlKey;
      }
      
      override public function clone() : WindowEvent
      {
         return allocate(_type,UnknownVarFromWindowKeyboardEvent_KeyboardEvent_1,window,related,cancelable);
      }
      
      override public function toString() : String
      {
         return "WindowKeyboardEvent { type: " + _type + " cancelable: " + _cancelable + " window: " + _window + " charCode: " + charCode + " }";
      }
   }
}

