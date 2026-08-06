package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindowModel;
   
   public class WindowDisposeEvent extends WindowEvent
   {
      public static const UnknownConstFromWindowDisposeEvent_String_1:String = "WINDOW_DISPOSE_EVENT";
      
      private static const UnknownConstFromWindowDisposeEvent_Array_1:Array = [];
      
      public function WindowDisposeEvent()
      {
         super();
         _type = "WINDOW_DISPOSE_EVENT";
      }
      
      public static function allocate(param1:IWindowModel) : WindowDisposeEvent
      {
         var _loc2_:WindowDisposeEvent = UnknownConstFromWindowDisposeEvent_Array_1.length > 0 ? UnknownConstFromWindowDisposeEvent_Array_1.pop() : new WindowDisposeEvent();
         _loc2_._window = param1;
         _loc2_.UnknownVarFromWindowEvent_Boolean_1 = false;
         _loc2_.UnknownVarFromWindowEvent_Array_1 = UnknownConstFromWindowDisposeEvent_Array_1;
         return _loc2_;
      }
      
      override public function clone() : WindowEvent
      {
         return allocate(window);
      }
      
      override public function toString() : String
      {
         return "WindowDisposeEvent { type: " + _type + " window: " + _window + " }";
      }
   }
}

