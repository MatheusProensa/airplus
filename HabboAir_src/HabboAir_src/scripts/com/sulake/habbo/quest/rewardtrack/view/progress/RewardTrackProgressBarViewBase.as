package com.sulake.habbo.quest.rewardtrack.view.progress
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.window.utils.AnimatedColor;
   import com.sulake.habbo.window.utils.AnimatedScalar;
   
   public class RewardTrackProgressBarViewBase implements IComponentInterfaceQueue
   {
      private static const ACCELERATION_PER_MS:Number = 0.00001;
      
      private static const MAX_SPEED_PER_MS:Number = 0.003;
      
      private static const UnknownConstFromRewardTrackProgressBarViewBase_Number_1:Number = 0.0001;
      
      private static const FILL_COLOR_TRANSITION_MS:Number = 300;
      
      private static const INCOMPLETE_COLOR:uint = 15443468;
      
      private static const COMPLETE_COLOR:uint = 7450404;
      
      protected var _container:IWindowController_1;
      
      protected var UnknownVarFromRewardTrackProgressBarViewBase_IWindowController_1_1:IWindowController_1;
      
      protected var UnknownVarFromRewardTrackProgressBarViewBase_AnimatedScalar_1:AnimatedScalar;
      
      protected var UnknownVarFromRewardTrackProgressBarViewBase_Number_1:Number = 0;
      
      private var UnknownVarFromRewardTrackProgressBarViewBase_IWindowModel_1:IWindowModel;
      
      private var _completionColor:AnimatedColor;
      
      private var _maxWidth:int;
      
      private var UnknownVarFromRewardTrackProgressBarViewBase_Boolean_1:Boolean;
      
      private var _disposed:Boolean;
      
      public function RewardTrackProgressBarViewBase(param1:IWindowController_1, param2:Boolean = false)
      {
         super();
         _container = param1;
         UnknownVarFromRewardTrackProgressBarViewBase_IWindowController_1_1 = param1.findChildByName("progress") as IWindowController_1;
         _maxWidth = param1.width;
         UnknownVarFromRewardTrackProgressBarViewBase_Boolean_1 = param2;
         UnknownVarFromRewardTrackProgressBarViewBase_AnimatedScalar_1 = new AnimatedScalar(0.00001,0.003,0.0001);
         if(UnknownVarFromRewardTrackProgressBarViewBase_Boolean_1)
         {
            UnknownVarFromRewardTrackProgressBarViewBase_IWindowModel_1 = UnknownVarFromRewardTrackProgressBarViewBase_IWindowController_1_1.findChildByName("loading_bar");
            _completionColor = new AnimatedColor(300);
            _completionColor.snapTo(15443468,UnknownVarFromRewardTrackProgressBarViewBase_Number_1);
         }
      }
      
      public function setRatio(param1:Number, param2:Boolean) : void
      {
         var _loc3_:Number = clampRatio(param1);
         if(param2)
         {
            UnknownVarFromRewardTrackProgressBarViewBase_AnimatedScalar_1.setTarget(_loc3_,UnknownVarFromRewardTrackProgressBarViewBase_Number_1);
         }
         else
         {
            UnknownVarFromRewardTrackProgressBarViewBase_AnimatedScalar_1.snapTo(_loc3_,UnknownVarFromRewardTrackProgressBarViewBase_Number_1);
         }
         syncCompletionColor(param2);
         render();
      }
      
      public function update(param1:uint) : void
      {
         UnknownVarFromRewardTrackProgressBarViewBase_Number_1 += param1;
         var _loc2_:Boolean = UnknownVarFromRewardTrackProgressBarViewBase_AnimatedScalar_1.update(UnknownVarFromRewardTrackProgressBarViewBase_Number_1);
         if(UnknownVarFromRewardTrackProgressBarViewBase_Boolean_1)
         {
            syncCompletionColor(true);
            _loc2_ = _completionColor.update(UnknownVarFromRewardTrackProgressBarViewBase_Number_1) || _loc2_;
         }
         if(_loc2_)
         {
            render();
         }
      }
      
      public function get isUpdating() : Boolean
      {
         return UnknownVarFromRewardTrackProgressBarViewBase_AnimatedScalar_1.needsUpdate(UnknownVarFromRewardTrackProgressBarViewBase_Number_1,_maxWidth) || UnknownVarFromRewardTrackProgressBarViewBase_Boolean_1 && _completionColor.needsUpdate(UnknownVarFromRewardTrackProgressBarViewBase_Number_1);
      }
      
      protected function render() : void
      {
         UnknownVarFromRewardTrackProgressBarViewBase_IWindowController_1_1.width = Math.max(0,Math.min(_maxWidth,Math.round(_maxWidth * UnknownVarFromRewardTrackProgressBarViewBase_AnimatedScalar_1.value)));
         if(UnknownVarFromRewardTrackProgressBarViewBase_Boolean_1)
         {
            UnknownVarFromRewardTrackProgressBarViewBase_IWindowModel_1.color = _completionColor.value;
         }
      }
      
      protected function clampRatio(param1:Number) : Number
      {
         return Math.max(0,Math.min(1,param1));
      }
      
      private function syncCompletionColor(param1:Boolean) : void
      {
         if(!UnknownVarFromRewardTrackProgressBarViewBase_Boolean_1)
         {
            return;
         }
         var _loc2_:uint = UnknownVarFromRewardTrackProgressBarViewBase_AnimatedScalar_1.value >= 1 ? 7450404 : 15443468;
         if(param1)
         {
            _completionColor.setTarget(_loc2_,UnknownVarFromRewardTrackProgressBarViewBase_Number_1);
         }
         else
         {
            _completionColor.snapTo(_loc2_,UnknownVarFromRewardTrackProgressBarViewBase_Number_1);
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
         UnknownVarFromRewardTrackProgressBarViewBase_IWindowController_1_1 = null;
         UnknownVarFromRewardTrackProgressBarViewBase_AnimatedScalar_1 = null;
         UnknownVarFromRewardTrackProgressBarViewBase_IWindowModel_1 = null;
         _completionColor = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

