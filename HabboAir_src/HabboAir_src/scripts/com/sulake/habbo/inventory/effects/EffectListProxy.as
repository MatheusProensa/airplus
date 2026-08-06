package com.sulake.habbo.inventory.effects
{
   import com.sulake.habbo.inventory.common.IThumbListDataProvider;
   
   public class EffectListProxy implements IThumbListDataProvider
   {
      private var UnknownVarFromEffectListProxy_EffectsModel_1:EffectsModel;
      
      private var UnknownVarFromEffectListProxy_Int_1:int;
      
      public function EffectListProxy(param1:EffectsModel, param2:int)
      {
         super();
         UnknownVarFromEffectListProxy_EffectsModel_1 = param1;
         UnknownVarFromEffectListProxy_Int_1 = param2;
      }
      
      public function dispose() : void
      {
         UnknownVarFromEffectListProxy_EffectsModel_1 = null;
      }
      
      public function getDrawableList() : Array
      {
         return UnknownVarFromEffectListProxy_EffectsModel_1.getEffects(UnknownVarFromEffectListProxy_Int_1);
      }
   }
}

