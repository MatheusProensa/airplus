package com.sulake.habbo.quest.rewardtrack.view.progress
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ShapeController;
   
   public class RewardTrackMainProgressBarView extends RewardTrackProgressBarViewBase
   {
      private var UnknownVarFromRewardTrackMainProgressBarView_ShapeController_1:ShapeController;
      
      public function RewardTrackMainProgressBarView(param1:IWindowController_1)
      {
         super(param1);
         UnknownVarFromRewardTrackMainProgressBarView_ShapeController_1 = param1.findChildByName("shape") as ShapeController;
      }
      
      public function refreshByX(param1:int, param2:Boolean) : void
      {
         setRatio(param1 / _container.width,param2);
      }
      
      override protected function render() : void
      {
         super.render();
         if(UnknownVarFromRewardTrackProgressBarViewBase_IWindowController_1_1.width >= _container.width - 4)
         {
            UnknownVarFromRewardTrackMainProgressBarView_ShapeController_1.width = _container.width;
         }
         else if(UnknownVarFromRewardTrackMainProgressBarView_ShapeController_1.width != UnknownVarFromRewardTrackProgressBarViewBase_IWindowController_1_1.width + 4)
         {
            UnknownVarFromRewardTrackMainProgressBarView_ShapeController_1.width = UnknownVarFromRewardTrackProgressBarViewBase_IWindowController_1_1.width + 4;
         }
      }
   }
}

