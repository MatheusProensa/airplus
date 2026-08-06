package com.sulake.habbo.avatar.common
{
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.inventory.IHabboInventory;
   
   public class CategoryBaseModel implements ICategoryBaseModel_1
   {
      protected var _categories:Map;
      
      protected var _controller:HabboAvatarEditor;
      
      protected var UnknownVarFromCategoryBaseModel_Boolean_1:Boolean = false;
      
      protected var UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1:ICategoryBaseModel_2;
      
      private var _disposed:Boolean;
      
      public function CategoryBaseModel(param1:HabboAvatarEditor)
      {
         super();
         _controller = param1;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1 != null)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.dispose();
         }
         UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1 = null;
         _categories = null;
         _controller = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      protected function init() : void
      {
         if(!_categories)
         {
            _categories = new Map();
         }
      }
      
      public function reset() : void
      {
         UnknownVarFromCategoryBaseModel_Boolean_1 = false;
         for each(var _loc1_ in _categories)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         _categories = new Map();
         if(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.reset();
         }
      }
      
      protected function initCategory(param1:String) : void
      {
         var _loc3_:CategoryData = null;
         var _loc2_:CategoryData = _categories[param1];
         if(_loc2_ == null)
         {
            _loc3_ = _controller.generateDataContent(this,param1);
            if(_loc3_)
            {
               _categories[param1] = _loc3_;
               updateSelectionsFromFigure(param1);
            }
         }
      }
      
      public function switchCategory(param1:String = "") : void
      {
         if(!UnknownVarFromCategoryBaseModel_Boolean_1)
         {
            init();
         }
         if(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.switchCategory(param1);
         }
      }
      
      protected function updateSelectionsFromFigure(param1:String) : void
      {
         if(!_categories || !_controller || !_controller.figureData)
         {
            return;
         }
         var _loc2_:CategoryData = _categories[param1];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:int = _controller.figureData.getPartSetId(param1);
         var _loc3_:Array = _controller.figureData.getColourIds(param1);
         if(!_loc3_)
         {
            _loc3_ = [];
         }
         _loc2_.selectPartId(_loc4_);
         _loc2_.selectColorIds(_loc3_);
         if(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.showPalettes(param1,_loc3_.length);
         }
      }
      
      public function hasClubItemsOverLevel(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         if(!_categories)
         {
            return false;
         }
         for each(var _loc3_ in _categories.getValues())
         {
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.hasClubSelectionsOverLevel(param1);
               if(_loc2_)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function hasInvalidSellableItems(param1:IHabboInventory) : Boolean
      {
         var _loc2_:Boolean = false;
         if(!_categories)
         {
            return false;
         }
         for each(var _loc3_ in _categories.getValues())
         {
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.hasInvalidSellableItems(param1);
               if(_loc2_)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function stripClubItemsOverLevel(param1:int) : Boolean
      {
         var _loc6_:int = 0;
         var _loc2_:String = null;
         var _loc7_:CategoryData = null;
         var _loc5_:Boolean = false;
         var _loc3_:AvatarEditorGridPartItem = null;
         if(!_categories)
         {
            return false;
         }
         var _loc8_:Array = _categories.getKeys();
         var _loc4_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc8_.length)
         {
            _loc2_ = _loc8_[_loc6_];
            _loc7_ = _categories[_loc2_];
            _loc5_ = false;
            if(_loc7_.stripClubItemsOverLevel(param1))
            {
               _loc5_ = true;
            }
            if(_loc7_.stripClubColorsOverLevel(param1))
            {
               _loc5_ = true;
            }
            if(_loc5_)
            {
               _loc3_ = _loc7_.getCurrentPart();
               if(_loc3_ && _controller && _controller.figureData && _loc7_)
               {
                  _controller.figureData.savePartData(_loc2_,_loc3_.id,_loc7_.getSelectedColorIds(),true);
               }
               _loc4_ = true;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function stripInvalidSellableItems() : Boolean
      {
         var _loc5_:int = 0;
         var _loc1_:String = null;
         var _loc6_:CategoryData = null;
         var _loc4_:Boolean = false;
         var _loc2_:AvatarEditorGridPartItem = null;
         if(!_categories)
         {
            return false;
         }
         var _loc7_:Array = _categories.getKeys();
         var _loc3_:Boolean = false;
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            _loc1_ = _loc7_[_loc5_];
            _loc6_ = _categories[_loc1_];
            _loc4_ = false;
            if(_loc6_.stripInvalidSellableItems(_controller.manager.inventory))
            {
               _loc4_ = true;
            }
            if(_loc4_)
            {
               _loc2_ = _loc6_.getCurrentPart();
               if(_loc2_ && _controller && _controller.figureData && _loc6_)
               {
                  _controller.figureData.savePartData(_loc1_,_loc2_.id,_loc6_.getSelectedColorIds(),true);
               }
               _loc3_ = true;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function selectPart(param1:String, param2:int) : void
      {
         var _loc3_:CategoryData = _categories[param1];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc5_:int = _loc3_.selectedPartIndex;
         _loc3_.selectPartIndex(param2);
         var _loc4_:AvatarEditorGridPartItem = _loc3_.getCurrentPart();
         if(!_loc4_)
         {
            return;
         }
         if(_loc4_.isDisabledForWearing)
         {
            _loc3_.selectPartIndex(_loc5_);
            _controller.openHabboClubAdWindow();
            return;
         }
         if(UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.showPalettes(param1,_loc4_.colorLayerCount);
         }
         if(_controller && _controller.figureData)
         {
            _controller.figureData.savePartData(param1,_loc4_.id,_loc3_.getSelectedColorIds(),true);
         }
      }
      
      public function selectColor(param1:String, param2:int, param3:int) : void
      {
         var _loc6_:AvatarEditorGridColorItem = null;
         var _loc5_:CategoryData = _categories[param1];
         if(_loc5_ == null)
         {
            return;
         }
         var _loc4_:int = _loc5_.getCurrentColorIndex(param3);
         _loc5_.selectColorIndex(param2,param3);
         if(_controller && _controller.figureData)
         {
            _loc6_ = _loc5_.getSelectedColor(param3);
            if(!_loc6_)
            {
               return;
            }
            if(_loc6_.isDisabledForWearing)
            {
               _loc5_.selectColorIndex(_loc4_,param3);
               _controller.openHabboClubAdWindow();
               return;
            }
            _controller.figureData.savePartSetColourId(param1,_loc5_.getSelectedColorIds(),true);
         }
      }
      
      public function get controller() : HabboAvatarEditor
      {
         return _controller;
      }
      
      public function getWindowContainer() : IWindowModel
      {
         if(!UnknownVarFromCategoryBaseModel_Boolean_1)
         {
            init();
         }
         if(!UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1)
         {
            return null;
         }
         return UnknownVarFromCategoryBaseModel_ICategoryBaseModel_2_1.getWindowContainer();
      }
      
      public function getCategoryData(param1:String) : CategoryData
      {
         if(!UnknownVarFromCategoryBaseModel_Boolean_1)
         {
            init();
         }
         if(!_categories)
         {
            return null;
         }
         return _categories[param1];
      }
   }
}

