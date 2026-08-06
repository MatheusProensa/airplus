package com.sulake.habbo.avatar.hotlooks
{
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_2;
   import com.sulake.habbo.avatar.wardrobe.Outfit;
   
   public class HotLooksView implements ICategoryBaseModel_2
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromHotLooksView_HotLooksModel_1:HotLooksModel;
      
      private var UnknownVarFromHotLooksView_IItemGridWindow_1:IItemGridWindow;
      
      public function HotLooksView(param1:HotLooksModel)
      {
         super();
         UnknownVarFromHotLooksView_HotLooksModel_1 = param1;
      }
      
      public function init() : void
      {
         if(UnknownVarFromHotLooksView_IItemGridWindow_1)
         {
            UnknownVarFromHotLooksView_IItemGridWindow_1.removeGridItems();
         }
         if(!_window)
         {
            _window = UnknownVarFromHotLooksView_HotLooksModel_1.controller.view.getCategoryContainer("hotlooks") as IWindowController_1;
            UnknownVarFromHotLooksView_IItemGridWindow_1 = _window.findChildByName("hotlooks") as IItemGridWindow;
            _window.visible = false;
         }
         update();
      }
      
      public function dispose() : void
      {
         UnknownVarFromHotLooksView_IItemGridWindow_1.removeGridItems();
         _window = null;
         UnknownVarFromHotLooksView_HotLooksModel_1 = null;
      }
      
      public function update() : void
      {
         var _loc2_:IWindowModel = null;
         UnknownVarFromHotLooksView_IItemGridWindow_1.removeGridItems();
         for each(var _loc1_ in UnknownVarFromHotLooksView_HotLooksModel_1.hotLooks)
         {
            _loc2_ = _loc1_.view.window;
            UnknownVarFromHotLooksView_IItemGridWindow_1.addGridItem(_loc2_);
            _loc2_.procedure = hotLooksEventProc;
         }
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return _window;
      }
      
      private function hotLooksEventProc(param1:WindowEvent, param2:IWindowModel = null) : void
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            param2 = param1.target as IWindowModel;
         }
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = UnknownVarFromHotLooksView_IItemGridWindow_1.getGridItemIndex(param2.parent);
            UnknownVarFromHotLooksView_HotLooksModel_1.selectHotLook(_loc3_);
         }
      }
      
      public function switchCategory(param1:String) : void
      {
      }
      
      public function showPalettes(param1:String, param2:int) : void
      {
      }
      
      public function reset() : void
      {
      }
   }
}

