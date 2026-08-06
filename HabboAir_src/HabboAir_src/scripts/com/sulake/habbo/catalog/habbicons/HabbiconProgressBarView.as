package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.window.utils.AnimatedColor;
   import com.sulake.habbo.window.utils.AnimatedScalar;
   
   public class HabbiconProgressBarView implements IComponentInterfaceQueue
   {
      private static const ACCELERATION_PER_MS:Number = 0.00001;
      
      private static const MAX_SPEED_PER_MS:Number = 0.003;
      
      private static const UnknownConstFromHabbiconProgressBarView_Number_1:Number = 0.0001;
      
      private static const FILL_COLOR_TRANSITION_MS:Number = 250;
      
      private static const INCOMPLETE_COLOR:uint = 5548264;
      
      private static const COMPLETE_COLOR:uint = 7915868;
      
      private static const CAP_OVERSHOOT:int = 4;
      
      private var _container:IWindowController_1;
      
      private var UnknownVarFromHabbiconProgressBarView_IWindowController_1_1:IWindowController_1;
      
      private var _fill:IWindowModel;
      
      private var _highlight:IWindowModel;
      
      private var UnknownVarFromHabbiconProgressBarView_AnimatedScalar_1:AnimatedScalar;
      
      private var _fillColor:AnimatedColor;
      
      private var UnknownVarFromHabbiconProgressBarView_Number_1:Number = 0;
      
      private var _maxWidth:int;
      
      private var _disposed:Boolean;
      
      public function HabbiconProgressBarView(param1:IWindowController_1)
      {
         super();
         _container = param1;
         UnknownVarFromHabbiconProgressBarView_IWindowController_1_1 = _container.findChildByName("progress") as IWindowController_1;
         _fill = UnknownVarFromHabbiconProgressBarView_IWindowController_1_1.findChildByName("fill");
         _highlight = UnknownVarFromHabbiconProgressBarView_IWindowController_1_1.findChildByName("highlight");
         _maxWidth = _container.width;
         UnknownVarFromHabbiconProgressBarView_AnimatedScalar_1 = new AnimatedScalar(0.00001,0.003,0.0001);
         _fillColor = new AnimatedColor(250);
         _fillColor.snapTo(5548264,UnknownVarFromHabbiconProgressBarView_Number_1);
         render();
      }
      
      public function setRatio(param1:Number, param2:Boolean) : void
      {
         var _loc3_:Number = Math.max(0,Math.min(1,param1));
         if(param2)
         {
            UnknownVarFromHabbiconProgressBarView_AnimatedScalar_1.setTarget(_loc3_,UnknownVarFromHabbiconProgressBarView_Number_1);
         }
         else
         {
            UnknownVarFromHabbiconProgressBarView_AnimatedScalar_1.snapTo(_loc3_,UnknownVarFromHabbiconProgressBarView_Number_1);
         }
         syncCompletionColor(param2);
         render();
      }
      
      public function update(param1:uint) : void
      {
         UnknownVarFromHabbiconProgressBarView_Number_1 += param1;
         var _loc2_:Boolean = UnknownVarFromHabbiconProgressBarView_AnimatedScalar_1.update(UnknownVarFromHabbiconProgressBarView_Number_1);
         syncCompletionColor(true);
         _loc2_ = _fillColor.update(UnknownVarFromHabbiconProgressBarView_Number_1) || _loc2_;
         if(_loc2_)
         {
            render();
         }
      }
      
      private function render() : void
      {
         var _loc1_:int = Math.max(0,Math.min(_maxWidth,Math.round(_maxWidth * UnknownVarFromHabbiconProgressBarView_AnimatedScalar_1.value)));
         var _loc2_:int = int(_loc1_ >= _maxWidth - 4 ? _maxWidth : _loc1_ + 4);
         UnknownVarFromHabbiconProgressBarView_IWindowController_1_1.width = _loc1_;
         UnknownVarFromHabbiconProgressBarView_IWindowController_1_1.visible = _loc1_ > 0;
         _fill.width = Math.max(0,_loc2_);
         _fill.color = _fillColor.value;
         _highlight.width = Math.max(0,_loc2_ - 2);
         _container.invalidate();
      }
      
      private function syncCompletionColor(param1:Boolean) : void
      {
         var _loc2_:uint = UnknownVarFromHabbiconProgressBarView_AnimatedScalar_1.value >= 1 ? 7915868 : 5548264;
         if(param1)
         {
            _fillColor.setTarget(_loc2_,UnknownVarFromHabbiconProgressBarView_Number_1);
         }
         else
         {
            _fillColor.snapTo(_loc2_,UnknownVarFromHabbiconProgressBarView_Number_1);
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         _container = null;
         UnknownVarFromHabbiconProgressBarView_IWindowController_1_1 = null;
         _fill = null;
         _highlight = null;
         UnknownVarFromHabbiconProgressBarView_AnimatedScalar_1 = null;
         _fillColor = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

