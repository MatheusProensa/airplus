package com.sulake.habbo.avatar.head
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   
   public class HeadModel extends CategoryBaseModel implements ICategoryBaseModel_1
   {
      public function HeadModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("hr");
         initCategory("ha");
         initCategory("he");
         initCategory("ea");
         initCategory("fa");
         UnknownVarFromCategoryBaseModel_Boolean_1 = true;
         if(!UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1 = new HeadView(this);
            if(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
            {
               UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.init();
            }
         }
      }
   }
}

