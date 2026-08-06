package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindowModel;
   
   public class WindowLinkEvent extends WindowEvent
   {
      public static const UnknownConstFromWindowLinkEvent_String_1:String = "WE_LINK";
      
      private static const UnknownConstFromWindowLinkEvent_Array_1:Array = [];
      
      private var _link:String;
      
      public function WindowLinkEvent()
      {
         super();
         _type = "WE_LINK";
      }
      
      public static function allocate(param1:String, param2:IWindowModel, param3:IWindowModel) : WindowEvent
      {
         var _loc4_:WindowLinkEvent = UnknownConstFromWindowLinkEvent_Array_1.length > 0 ? UnknownConstFromWindowLinkEvent_Array_1.pop() : new WindowLinkEvent();
         _loc4_._link = param1;
         _loc4_._window = param2;
         _loc4_._related = param3;
         _loc4_.UnknownVarFromWindowEvent_Boolean_1 = false;
         _loc4_.UnknownVarFromWindowEvent_Array_1 = UnknownConstFromWindowLinkEvent_Array_1;
         return _loc4_;
      }
      
      public function get link() : String
      {
         return _link;
      }
      
      override public function clone() : WindowEvent
      {
         return allocate(_link,window,related);
      }
      
      override public function toString() : String
      {
         return "WindowLinkEvent { type: " + _type + " link: " + link + " cancelable: " + _cancelable + " window: " + _window + " }";
      }
   }
}

