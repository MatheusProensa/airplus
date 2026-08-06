package com.sulake.habbo.avatar.common
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   
   public class CategoryBaseView
   {
      protected var _window:IWindowController_1;
      
      protected var UnknownVarFromCategoryBaseView_String_1:String = "";
      
      protected var _currentTabName:String = "";
      
      protected var UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1:ICategoryBaseModel_1;
      
      protected var UnknownVarFromCategoryBaseView_Boolean_1:Boolean;
      
      public function CategoryBaseView(param1:ICategoryBaseModel_1)
      {
         super();
         UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1 = param1;
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1 = null;
         UnknownVarFromCategoryBaseView_Boolean_1 = false;
      }
      
      public function init() : void
      {
      }
      
      public function reset() : void
      {
         UnknownVarFromCategoryBaseView_String_1 = "";
         _currentTabName = "";
         UnknownVarFromCategoryBaseView_Boolean_1 = false;
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         if(!UnknownVarFromCategoryBaseView_Boolean_1)
         {
            init();
         }
         return _window;
      }
      
      public function showPalettes(param1:String, param2:int) : void
      {
         UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.view.gridView.showPalettes(param2);
      }
      
      protected function updateGridView(param1:String) : void
      {
         UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1.controller.view.gridView.initFromList(UnknownVarFromCategoryBaseView_ICategoryBaseModel_1_1,param1);
      }
      
      protected function activateTab(param1:String) : void
      {
         var _loc2_:IStaticBitmapWrapperWindow = null;
         if(!_window)
         {
            return;
         }
         var _loc3_:IWindowController_1 = _window.findChildByName(param1) as IWindowController_1;
         if(_loc3_)
         {
            _loc2_ = _loc3_.findChildByTag("BITMAP") as IStaticBitmapWrapperWindow;
            TabUtils.setElementImage(_loc2_,true);
         }
      }
      
      protected function inactivateTab(param1:String) : void
      {
         var _loc2_:IStaticBitmapWrapperWindow = null;
         if(!_window)
         {
            return;
         }
         var _loc3_:IWindowController_1 = _window.findChildByName(param1) as IWindowController_1;
         if(_loc3_)
         {
            _loc2_ = _loc3_.findChildByTag("BITMAP") as IStaticBitmapWrapperWindow;
            TabUtils.setElementImage(_loc2_,false);
         }
      }
   }
}

