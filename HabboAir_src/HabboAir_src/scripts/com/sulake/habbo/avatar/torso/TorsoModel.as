package com.sulake.habbo.avatar.torso
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   
   public class TorsoModel extends CategoryBaseModel implements ICategoryBaseModel_1
   {
      public function TorsoModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("cc");
         initCategory("ch");
         initCategory("ca");
         initCategory("cp");
         UnknownVarFromCategoryBaseModel_Boolean_1 = true;
         if(!UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1 = new TorsoView(this);
            if(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
            {
               UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.init();
            }
         }
      }
   }
}

