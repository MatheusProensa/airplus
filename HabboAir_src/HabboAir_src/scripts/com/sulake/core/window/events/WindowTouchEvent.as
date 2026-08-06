package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindowModel;
   
   public class WindowTouchEvent extends WindowEvent
   {
      public static const WINDOW_EVENT_TOUCH_BEGIN:String = "WTE_BEGIN";
      
      public static const UnknownConstFromWindowTouchEvent_String_1:String = "WTE_END";
      
      public static const WINDOW_EVENT_TOUCH_MOVE:String = "WTE_MOVE";
      
      public static const UnknownConstFromWindowTouchEvent_String_2:String = "WTE_OUT";
      
      public static const WINDOW_EVENT_TOUCH_OVER:String = "WTE_OVER";
      
      public static const UnknownConstFromWindowTouchEvent_String_3:String = "WTE_ROLL_OUT";
      
      public static const WINDOW_EVENT_TOUCH_ROLL_OVER:String = "WTE_ROLL_OVER";
      
      public static const UnknownConstFromWindowTouchEvent_String_4:String = "WTE_TAP";
      
      private static const UnknownConstFromWindowTouchEvent_Array_1:Array = [];
      
      public var localX:Number;
      
      public var localY:Number;
      
      public var stageX:Number;
      
      public var stageY:Number;
      
      public var altKey:Boolean;
      
      public var ctrlKey:Boolean;
      
      public var shiftKey:Boolean;
      
      public var UnknownVarFromWindowTouchEvent_Number_1:Number;
      
      public var sizeX:Number;
      
      public var sizeY:Number;
      
      public function WindowTouchEvent()
      {
         super();
      }
      
      public static function allocate(param1:String, param2:IWindowModel, param3:IWindowModel, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Boolean, param12:Boolean, param13:Boolean) : WindowTouchEvent
      {
         var _loc14_:WindowTouchEvent = UnknownConstFromWindowTouchEvent_Array_1.length > 0 ? UnknownConstFromWindowTouchEvent_Array_1.pop() : new WindowTouchEvent();
         _loc14_._type = param1;
         _loc14_._window = param2;
         _loc14_._related = param3;
         _loc14_.UnknownVarFromWindowEvent_Boolean_1 = false;
         _loc14_.UnknownVarFromWindowEvent_Array_1 = UnknownConstFromWindowTouchEvent_Array_1;
         _loc14_.sizeX = param6;
         _loc14_.sizeY = param7;
         _loc14_.localX = param4;
         _loc14_.localY = param5;
         _loc14_.stageX = param8;
         _loc14_.stageY = param9;
         _loc14_.UnknownVarFromWindowTouchEvent_Number_1 = param10;
         _loc14_.altKey = param11;
         _loc14_.ctrlKey = param12;
         _loc14_.shiftKey = param13;
         return _loc14_;
      }
      
      override public function clone() : WindowEvent
      {
         return allocate(_type,window,related,localX,localY,sizeX,sizeY,stageX,stageY,UnknownVarFromWindowTouchEvent_Number_1,altKey,ctrlKey,shiftKey);
      }
      
      override public function toString() : String
      {
         return "WindowTouchEvent { type: " + _type + " cancelable: " + _cancelable + " window: " + _window + " localX: " + localX + " localY: " + localY + " }";
      }
   }
}

