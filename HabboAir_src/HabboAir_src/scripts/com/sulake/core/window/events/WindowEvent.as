package com.sulake.core.window.events
{
   import com.sulake.core.window.IWindowModel;
   
   public class WindowEvent
   {
      public static const UnknownConstFromWindowEvent_String_1:String = "WE_DESTROY";
      
      public static const UnknownConstFromWindowEvent_String_2:String = "WE_DESTROYED";
      
      public static const UnknownConstFromWindowEvent_String_3:String = "WE_OPEN";
      
      public static const UnknownConstFromWindowEvent_String_4:String = "WE_OPENED";
      
      public static const UnknownConstFromWindowEvent_String_5:String = "WE_CLOSE";
      
      public static const UnknownConstFromWindowEvent_String_6:String = "WE_CLOSED";
      
      public static const WINDOW_EVENT_FOCUS:String = "WE_FOCUS";
      
      public static const UnknownConstFromWindowEvent_String_7:String = "WE_FOCUSED";
      
      public static const WINDOW_EVENT_UNFOCUS:String = "WE_UNFOCUS";
      
      public static const UnknownConstFromWindowEvent_String_8:String = "WE_UNFOCUSED";
      
      public static const UnknownConstFromWindowEvent_String_9:String = "WE_ACTIVATE";
      
      public static const UnknownConstFromWindowEvent_String_10:String = "WE_ACTIVATED";
      
      public static const UnknownConstFromWindowEvent_String_11:String = "WE_DEACTIVATE";
      
      public static const UnknownConstFromWindowEvent_String_12:String = "WE_DEACTIVATED";
      
      public static const UnknownConstFromWindowEvent_String_13:String = "WE_SELECT";
      
      public static const UnknownConstFromWindowEvent_String_14:String = "WE_SELECTED";
      
      public static const UnknownConstFromWindowEvent_String_15:String = "WE_UNSELECT";
      
      public static const UnknownConstFromWindowEvent_String_16:String = "WE_UNSELECTED";
      
      public static const WINDOW_EVENT_LOCK:String = "WE_LOCK";
      
      public static const UnknownConstFromWindowEvent_String_17:String = "WE_LOCKED";
      
      public static const WINDOW_EVENT_UNLOCK:String = "WE_UNLOCK";
      
      public static const UnknownConstFromWindowEvent_String_18:String = "WE_UNLOCKED";
      
      public static const UnknownConstFromWindowEvent_String_19:String = "WE_ENABLE";
      
      public static const UnknownConstFromWindowEvent_String_20:String = "WE_ENABLED";
      
      public static const UnknownConstFromWindowEvent_String_21:String = "WE_DISABLE";
      
      public static const UnknownConstFromWindowEvent_String_22:String = "WE_DISABLED";
      
      public static const UnknownConstFromWindowEvent_String_23:String = "WE_RELOCATE";
      
      public static const UnknownConstFromWindowEvent_String_24:String = "WE_RELOCATED";
      
      public static const UnknownConstFromWindowEvent_String_25:String = "WE_RESIZE";
      
      public static const UnknownConstFromWindowEvent_String_26:String = "WE_RESIZED";
      
      public static const UnknownConstFromWindowEvent_String_27:String = "WE_MINIMIZE";
      
      public static const UnknownConstFromWindowEvent_String_28:String = "WE_MINIMIZED";
      
      public static const UnknownConstFromWindowEvent_String_29:String = "WE_MAXIMIZE";
      
      public static const UnknownConstFromWindowEvent_String_30:String = "WE_MAXIMIZED";
      
      public static const WINDOW_EVENT_RESTORE:String = "WE_RESTORE";
      
      public static const UnknownConstFromWindowEvent_String_31:String = "WE_RESTORED";
      
      public static const UnknownConstFromWindowEvent_String_32:String = "WE_EXPANDED";
      
      public static const UnknownConstFromWindowEvent_String_33:String = "WE_COLLAPSE";
      
      public static const UnknownConstFromWindowEvent_String_34:String = "WE_CHILD_ADDED";
      
      public static const UnknownConstFromWindowEvent_String_35:String = "WE_CHILD_REMOVED";
      
      public static const UnknownConstFromWindowEvent_String_36:String = "WE_CHILD_RELOCATED";
      
      public static const UnknownConstFromWindowEvent_String_37:String = "WE_CHILD_RESIZED";
      
      public static const UnknownConstFromWindowEvent_String_38:String = "WE_CHILD_ACTIVATED";
      
      public static const UnknownConstFromWindowEvent_String_39:String = "WE_CHILD_VISIBILITY";
      
      public static const UnknownConstFromWindowEvent_String_40:String = "WE_PARENT_ADDED";
      
      public static const UnknownConstFromWindowEvent_String_41:String = "WE_PARENT_REMOVED";
      
      public static const UnknownConstFromWindowEvent_String_42:String = "WE_PARENT_RELOCATED";
      
      public static const UnknownConstFromWindowEvent_String_43:String = "WE_PARENT_RESIZED";
      
      public static const UnknownConstFromWindowEvent_String_44:String = "WE_PARENT_ACTIVATED";
      
      public static const UnknownConstFromWindowEvent_String_45:String = "WE_OK";
      
      public static const UnknownConstFromWindowEvent_String_46:String = "WE_CANCEL";
      
      public static const WINDOW_EVENT_CHANGE:String = "WE_CHANGE";
      
      public static const UnknownConstFromWindowEvent_String_47:String = "WE_SCROLL";
      
      public static const UNKNOWN:String = "";
      
      private static const UnknownConstFromWindowEvent_Array_1:Array = [];
      
      protected var _type:String;
      
      protected var _window:IWindowModel;
      
      protected var _related:IWindowModel;
      
      protected var _isDefaultPrevented:Boolean;
      
      protected var _cancelable:Boolean;
      
      protected var UnknownVarFromWindowEvent_Boolean_1:Boolean;
      
      protected var UnknownVarFromWindowEvent_Array_1:Array;
      
      public function WindowEvent()
      {
         super();
      }
      
      public static function allocate(param1:String, param2:IWindowModel, param3:IWindowModel, param4:Boolean = false) : WindowEvent
      {
         var _loc5_:WindowEvent = UnknownConstFromWindowEvent_Array_1.length > 0 ? UnknownConstFromWindowEvent_Array_1.pop() : new WindowEvent();
         _loc5_._type = param1;
         _loc5_._window = param2;
         _loc5_._related = param3;
         _loc5_._cancelable = param4;
         _loc5_.UnknownVarFromWindowEvent_Boolean_1 = false;
         _loc5_.UnknownVarFromWindowEvent_Array_1 = UnknownConstFromWindowEvent_Array_1;
         return _loc5_;
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get target() : IWindowModel
      {
         return _window;
      }
      
      public function get window() : IWindowModel
      {
         return _window;
      }
      
      public function get related() : IWindowModel
      {
         return _related;
      }
      
      public function get cancelable() : Boolean
      {
         return _cancelable;
      }
      
      public function recycle() : void
      {
         if(UnknownVarFromWindowEvent_Boolean_1)
         {
            throw new Error("Event already recycled!");
         }
         _window = _related = null;
         UnknownVarFromWindowEvent_Boolean_1 = true;
         _isDefaultPrevented = false;
         UnknownVarFromWindowEvent_Array_1.push(this);
      }
      
      public function clone() : WindowEvent
      {
         return allocate(_type,window,related,cancelable);
      }
      
      public function preventDefault() : void
      {
         preventWindowOperation();
      }
      
      public function isDefaultPrevented() : Boolean
      {
         return _isDefaultPrevented;
      }
      
      public function preventWindowOperation() : void
      {
         if(cancelable)
         {
            _isDefaultPrevented = true;
            return;
         }
         throw new Error("Attempted to prevent window operation that is not cancelable!");
      }
      
      public function isWindowOperationPrevented() : Boolean
      {
         return _isDefaultPrevented;
      }
      
      public function stopPropagation() : void
      {
         _isDefaultPrevented = true;
      }
      
      public function stopImmediatePropagation() : void
      {
         _isDefaultPrevented = true;
      }
      
      public function toString() : String
      {
         return "WindowEvent { type: " + _type + " cancelable: " + _cancelable + " window: " + _window + " }";
      }
   }
}

