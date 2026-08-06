package com.sulake.habbo.roomevents.wired_setup.uibuilder
{
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.ListScrollParams;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout.FramePreset;
   import flash.system.Capabilities;
   
   public class WiredUIBuilder
   {
      private var UnknownVarFromWiredUIBuilder_PresetManager_1:PresetManager;
      
      private var UnknownVarFromWiredUIBuilder_Function_1:Function;
      
      private var _holderKey:String;
      
      private var _code:int;
      
      private var _frame:FramePreset;
      
      protected var UnknownVarFromWiredUIBuilder_Array_1:Array;
      
      private var UnknownVarFromWiredUIBuilder_Boolean_1:Boolean;
      
      private var _initialWidth:int;
      
      public function WiredUIBuilder(param1:PresetManager, param2:Function, param3:String, param4:int, param5:Boolean = false)
      {
         super();
         UnknownVarFromWiredUIBuilder_PresetManager_1 = param1;
         UnknownVarFromWiredUIBuilder_Function_1 = param2;
         UnknownVarFromWiredUIBuilder_Boolean_1 = param5;
         _holderKey = param3;
         _code = param4;
         UnknownVarFromWiredUIBuilder_Array_1 = [];
      }
      
      public function addElements(... rest) : void
      {
         for each(var _loc2_ in rest)
         {
            UnknownVarFromWiredUIBuilder_Array_1.push(_loc2_);
         }
      }
      
      public function get frame() : FramePreset
      {
         return _frame;
      }
      
      public function build(param1:Number = 1, param2:Boolean = false) : void
      {
         var _loc3_:ListScrollParams = null;
         if(param2)
         {
            _loc3_ = new ListScrollParams(false,0,Capabilities.screenResolutionY / 1.8,true,true);
         }
         _frame = UnknownVarFromWiredUIBuilder_PresetManager_1.createFramePreset(UnknownVarFromWiredUIBuilder_Array_1,UnknownVarFromWiredUIBuilder_Function_1,_holderKey,_code,UnknownVarFromWiredUIBuilder_Boolean_1,true,_loc3_);
         UnknownVarFromWiredUIBuilder_Array_1 = null;
         _initialWidth = _frame.window.width;
         _frame.resizeToWidth(_initialWidth * param1);
      }
      
      public function get initialWidth() : int
      {
         return _initialWidth;
      }
   }
}

