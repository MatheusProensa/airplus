package com.sulake.habbo.avatar.misc
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   
   public class MiscModel extends CategoryBaseModel implements ICategoryBaseModel_1
   {
      public function MiscModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("pt");
         initCategory("mc");
         ensureEmptyCategory("pt");
         ensureEmptyCategory("mc");
         UnknownVarFromCategoryBaseModel_Boolean_1 = true;
         if(!UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1 = new MiscView(this);
            if(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
            {
               UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.init();
            }
         }
      }
      
      private function ensureEmptyCategory(param1:String) : void
      {
         if(!_categories || _categories[param1] != null)
         {
            return;
         }
         _categories[param1] = new CategoryData([],[]);
      }
   }
}

