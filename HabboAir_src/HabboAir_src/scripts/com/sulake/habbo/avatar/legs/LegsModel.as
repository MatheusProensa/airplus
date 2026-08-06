package com.sulake.habbo.avatar.legs
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   
   public class LegsModel extends CategoryBaseModel implements ICategoryBaseModel_1
   {
      public function LegsModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("lg");
         initCategory("sh");
         initCategory("wa");
         UnknownVarFromCategoryBaseModel_Boolean_1 = true;
         if(!UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1 = new LegsView(this);
            if(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
            {
               UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.init();
            }
         }
      }
   }
}

