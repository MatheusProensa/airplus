package com.sulake.core.window.components
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.theme.IThemeManager;
   import flash.geom.Rectangle;
   
   public class TextLinkController extends TextController implements ITextLinkWindow
   {
      private var _toolTipDelay:uint;
      
      private var _toolTipCaption:String;
      
      private var _toolTipIsDynamic:Boolean;
      
      protected var _interactiveCursorDisabled:Boolean;
      
      protected var UnknownVarFromTextLinkController_Map_1:Map;
      
      public function TextLinkController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var _loc12_:IThemeManager = param5.getWindowFactory().getThemeManager();
         _toolTipDelay = int(_loc12_.getPropertyDefaults(param3).get("tool_tip_delay").value);
         _toolTipCaption = String(_loc12_.getPropertyDefaults(param3).get("tool_tip_caption").value);
         _toolTipIsDynamic = _loc12_.getPropertyDefaults(param3).get("tool_tip_is_dynamic").value;
         _interactiveCursorDisabled = _loc12_.getPropertyDefaults(param3).get("interactive_cursor_disabled").value;
         super(param1,param2,param3,(param4 | 1) & ~0x10,param5,param6,param7,param8,param9,param10,param11);
         immediateClickMode = true;
         mouseThreshold = 0;
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         var _loc3_:Boolean = super.update(param1,param2);
         if(param1 == this)
         {
            InteractiveController.processInteractiveWindowEvents(this,param2);
         }
         return _loc3_;
      }
      
      public function set mouseCursorType(param1:uint) : void
      {
      }
      
      public function get mouseCursorType() : uint
      {
         return 0;
      }
      
      public function set toolTipCaption(param1:String) : void
      {
         _toolTipCaption = param1 == null ? "" : param1;
      }
      
      public function get toolTipCaption() : String
      {
         return _toolTipCaption;
      }
      
      public function set toolTipDelay(param1:uint) : void
      {
         _toolTipDelay = param1;
      }
      
      public function get toolTipDelay() : uint
      {
         return _toolTipDelay;
      }
      
      public function setMouseCursorForState(param1:uint, param2:uint) : uint
      {
         if(!UnknownVarFromTextLinkController_Map_1)
         {
            UnknownVarFromTextLinkController_Map_1 = new Map();
         }
         var _loc3_:uint = uint(UnknownVarFromTextLinkController_Map_1[param1]);
         if(param2 == 0 || param2 == -1)
         {
            UnknownVarFromTextLinkController_Map_1.remove(param1);
         }
         else
         {
            UnknownVarFromTextLinkController_Map_1[param1] = param2;
         }
         return _loc3_;
      }
      
      public function getMouseCursorByState(param1:uint) : uint
      {
         if(!UnknownVarFromTextLinkController_Map_1)
         {
            return 0;
         }
         return UnknownVarFromTextLinkController_Map_1.getValue(param1);
      }
      
      public function showToolTip(param1:IToolTipWindow) : void
      {
         throw new Error("Unimplemented method!");
      }
      
      public function hideToolTip() : void
      {
         throw new Error("Unimplemented method!");
      }
      
      override public function get properties() : Array
      {
         return InteractiveController.writeInteractiveWindowProperties(this,super.properties);
      }
      
      override public function set properties(param1:Array) : void
      {
         InteractiveController.readInteractiveWindowProperties(this,param1);
         super.properties = param1;
      }
      
      public function set toolTipIsDynamic(param1:Boolean) : void
      {
         _toolTipIsDynamic = param1;
      }
      
      public function get toolTipIsDynamic() : Boolean
      {
         return _toolTipIsDynamic;
      }
      
      public function get interactiveCursorDisabled() : Boolean
      {
         return _interactiveCursorDisabled;
      }
      
      public function set interactiveCursorDisabled(param1:Boolean) : void
      {
         _interactiveCursorDisabled = param1;
      }
   }
}

