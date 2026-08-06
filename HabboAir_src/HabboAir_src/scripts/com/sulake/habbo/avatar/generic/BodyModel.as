package com.sulake.habbo.avatar.generic
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.avatar.common.AvatarEditorGridColorItem;
   import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   
   public class BodyModel extends CategoryBaseModel implements ICategoryBaseModel_1, UnknownIHabboAvatar1
   {
      public function BodyModel(param1:HabboAvatarEditor)
      {
         super(param1);
      }
      
      override protected function init() : void
      {
         super.init();
         initCategory("hd");
         UnknownVarFromCategoryBaseModel_Boolean_1 = true;
         if(!UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1 = new BodyView(this);
            if(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
            {
               UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.init();
            }
         }
      }
      
      override public function switchCategory(param1:String = "") : void
      {
         UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.switchCategory(param1);
      }
      
      override public function selectColor(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:CategoryData = _categories[param1];
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.selectColorIndex(param2,param3);
         var _loc5_:AvatarEditorGridColorItem = _loc4_.getSelectedColor(param3);
         if(_loc5_.isDisabledForWearing)
         {
            _controller.openHabboClubAdWindow();
            return;
         }
         _controller.figureData.savePartSetColourId(param1,_loc4_.getSelectedColorIds(),true);
         updateSelectionsFromFigure("hd");
      }
      
      override protected function updateSelectionsFromFigure(param1:String) : void
      {
         var _loc2_:CategoryData = getFaceCategoryData();
         if(!_loc2_)
         {
            return;
         }
         updateIconImage(_loc2_);
      }
      
      private function getFaceCategoryData() : CategoryData
      {
         if(!_categories)
         {
            return null;
         }
         var _loc1_:CategoryData = _categories["hd"];
         if(_loc1_ == null)
         {
            return null;
         }
         var _loc3_:int = _controller.figureData.getPartSetId("hd");
         var _loc2_:Array = _controller.figureData.getColourIds("hd");
         _loc1_.selectPartId(_loc3_);
         _loc1_.selectColorIds(_loc2_);
         return _loc1_;
      }
      
      private function updateIconImage(param1:CategoryData, param2:String = null) : void
      {
         var _loc5_:String = null;
         var _loc4_:IAvatarImage_2 = null;
         for each(var _loc3_ in param1.parts)
         {
            if(_loc3_.partSet)
            {
               _loc5_ = _controller.figureData.getFigureStringWithFace(_loc3_.id);
               if(param2 == null || param2 == _loc5_)
               {
                  _loc4_ = _controller.manager.avatarRenderManager.createAvatarImage(_loc5_,"h",null,this);
                  _loc3_.iconImage = _loc4_.getCroppedImage("head");
                  _loc4_.dispose();
               }
            }
         }
      }
      
      public function avatarImageReady(param1:String) : void
      {
         var _loc2_:CategoryData = getFaceCategoryData();
         if(!_loc2_)
         {
            return;
         }
         updateIconImage(_loc2_,param1);
      }
   }
}

