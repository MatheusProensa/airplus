package com.sulake.habbo.avatar.effects
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar3;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   import com.sulake.habbo.inventory.IInventoryMainView;
   import flash.utils.Dictionary;
   
   public class EffectsModel extends CategoryBaseModel implements ICategoryBaseModel_1
   {
      public static const GRIDTYPE_EFFECTS:String = "effects";
      
      private var UnknownVarFromEffectsModel_Dictionary_1:Dictionary = new Dictionary();
      
      private var UnknownVarFromEffectsModel_EffectsParamView_1:EffectsParamView;
      
      public function EffectsModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         UnknownVarFromCategoryBaseModel_Boolean_1 = true;
         if(!UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1 = new EffectsView(this);
            UnknownVarFromEffectsModel_EffectsParamView_1 = new EffectsParamView(this,controller.manager.windowManager,controller.manager.assets);
            if(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
            {
               UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.init();
            }
         }
      }
      
      public function get effects() : Array
      {
         if(controller.manager.inventory == null)
         {
            return [];
         }
         return controller.manager.inventory.getAvatarEffects();
      }
      
      override public function selectPart(param1:String, param2:int) : void
      {
         var _loc3_:UnknownIHabboAvatar3 = null;
         setSelectionVisual(param1,UnknownVarFromEffectsModel_Dictionary_1[param1],false);
         var _loc5_:int = controller.figureData.avatarEffectType;
         if(param2 == -1 && _loc5_ != -1)
         {
            param2 = int(EffectsView(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1).getGridIndex(_loc5_));
            for each(var _loc4_ in effects)
            {
               if(_loc4_.type == _loc5_)
               {
                  _loc3_ = UnknownIHabboAvatar3(_loc4_);
                  _loc3_.isSelected = true;
                  break;
               }
            }
         }
         else if(param2 == -1 && _loc5_ == -1 || param2 == 0)
         {
            param2 = 0;
            controller.setAvatarEffectType(-1);
            UnknownVarFromEffectsModel_EffectsParamView_1.updateView(null);
         }
         else
         {
            _loc3_ = UnknownIHabboAvatar3(effects[param2 - 1]);
            _loc3_.isSelected = true;
            controller.setAvatarEffectType(_loc3_.type);
         }
         UnknownVarFromEffectsModel_Dictionary_1[param1] = param2;
         setSelectionVisual(param1,param2,true);
         UnknownVarFromEffectsModel_EffectsParamView_1.updateView(_loc3_);
      }
      
      private function setSelectionVisual(param1:String, param2:int, param3:Boolean) : void
      {
         EffectsView(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1).updateSelectionVisual(param1,param2,param3);
      }
   }
}

