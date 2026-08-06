package com.sulake.core.window.components
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import flash.geom.Rectangle;
   
   public class RegionController extends ContainerController implements IRegionWindow
   {
      protected static const KEY_TOOLTIP_CAPTION:String = "tool_tip_caption";
      
      protected static const DEF_TOOLTIP_CAPTION:String = "";
      
      protected static const KEY_TOOLTIP_DELAY:String = "tool_tip_delay";
      
      protected static const DEF_TOOLTIP_DELAY:uint = 500;
      
      protected var _toolTipDelay:uint = 500;
      
      protected var _toolTipCaption:String = "";
      
      protected var _toolTipIsDynamic:Boolean = false;
      
      private var _interactiveCursorDisabled:Boolean = false;
      
      protected var UnknownVarFromRegionController_Map_1:Map;
      
      public function RegionController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         param4 |= 1;
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
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
      
      public function showToolTip(param1:IToolTipWindow) : void
      {
      }
      
      public function hideToolTip() : void
      {
      }
      
      public function setMouseCursorForState(param1:uint, param2:uint) : uint
      {
         if(!UnknownVarFromRegionController_Map_1)
         {
            UnknownVarFromRegionController_Map_1 = new Map();
         }
         var _loc3_:uint = uint(UnknownVarFromRegionController_Map_1[param1]);
         if(param2 == 0 || param2 == -1)
         {
            UnknownVarFromRegionController_Map_1.remove(param1);
         }
         else
         {
            UnknownVarFromRegionController_Map_1[param1] = param2;
         }
         return _loc3_;
      }
      
      public function getMouseCursorByState(param1:uint) : uint
      {
         if(testStateFlag(32))
         {
            return 1;
         }
         if(!UnknownVarFromRegionController_Map_1)
         {
            return 0;
         }
         return UnknownVarFromRegionController_Map_1.getValue(param1);
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

