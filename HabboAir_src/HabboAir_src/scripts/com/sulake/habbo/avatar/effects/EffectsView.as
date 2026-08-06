package com.sulake.habbo.avatar.effects
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.habbo.avatar.common.CategoryBaseView;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_2;
   
   public class EffectsView extends CategoryBaseView implements ICategoryBaseModel_2
   {
      public function EffectsView(param1:ICategoryBaseModel_1)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         if(!_window)
         {
            _window = UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.view.getCategoryContainer("effects") as IWindowController_1;
            _window.visible = false;
         }
         if(UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1 && UnknownVarFromCategoryBaseView_String_1 == "")
         {
            UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.switchCategory("effects");
         }
         UnknownVarFromCategoryBaseView_Boolean_1 = true;
         updateGridView(UnknownVarFromCategoryBaseView_String_1);
      }
      
      override public function reset() : void
      {
         updateGridView(UnknownVarFromCategoryBaseView_String_1);
         UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.selectPart(UnknownVarFromCategoryBaseView_String_1,-1);
      }
      
      public function switchCategory(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.disposed)
         {
            return;
         }
         param1 = param1 == "" ? UnknownVarFromCategoryBaseView_String_1 : param1;
         UnknownVarFromCategoryBaseView_String_1 = param1;
         if(!UnknownVarFromCategoryBaseView_Boolean_1)
         {
            init();
         }
         updateGridView(UnknownVarFromCategoryBaseView_String_1);
      }
      
      public function updateSelectionVisual(param1:String, param2:int, param3:Boolean) : void
      {
         AvatarEditorGridViewEffects(UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.view.effectsGridView).updateSelection(param2,param3);
      }
      
      public function getGridIndex(param1:int) : int
      {
         return AvatarEditorGridViewEffects(UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.view.effectsGridView).getGridIndex(param1);
      }
      
      override protected function updateGridView(param1:String) : void
      {
         UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.view.effectsGridView.initFromList(UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1,param1);
      }
   }
}

