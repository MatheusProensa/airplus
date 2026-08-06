package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.avatar.common.ISideContentView;
   
   public class WardrobeView implements ISideContentView
   {
      public static const SLOTS_PER_COL:int = 7;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromWardrobeView_WardrobeModel_1:WardrobeModel;
      
      private var UnknownVarFromWardrobeView_IItemListWindow_1:IItemListWindow;
      
      private var UnknownVarFromWardrobeView_IItemListWindow_2:IItemListWindow;
      
      private var _slotTemplate:IWindowModel;
      
      public function WardrobeView(param1:WardrobeModel)
      {
         var _loc4_:int = 0;
         var _loc3_:IItemListWindow = null;
         super();
         UnknownVarFromWardrobeView_WardrobeModel_1 = param1;
         var _loc2_:XmlAsset = UnknownVarFromWardrobeView_WardrobeModel_1.controller.manager.assets.getAssetByName("avatareditor_wardrobe_base") as XmlAsset;
         _window = UnknownVarFromWardrobeView_WardrobeModel_1.controller.manager.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
         UnknownVarFromWardrobeView_IItemListWindow_1 = _window.findChildByName("slots_columns_list") as IItemListWindow;
         UnknownVarFromWardrobeView_IItemListWindow_2 = UnknownVarFromWardrobeView_IItemListWindow_1.findChildByName("slots_column_template") as IItemListWindow;
         _slotTemplate = UnknownVarFromWardrobeView_IItemListWindow_2.findChildByName("slot_template");
         UnknownVarFromWardrobeView_IItemListWindow_2.removeListItems();
         UnknownVarFromWardrobeView_IItemListWindow_1.removeListItems();
         var _loc5_:int = (param1.availableSlots + 7 - 1) / 7;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = UnknownVarFromWardrobeView_IItemListWindow_2.clone() as IItemListWindow;
            UnknownVarFromWardrobeView_IItemListWindow_1.addListItem(_loc3_);
            _loc4_ += 1;
         }
         _window.visible = false;
      }
      
      public function get slotTemplate() : IWindowModel
      {
         return _slotTemplate;
      }
      
      public function dispose() : void
      {
         UnknownVarFromWardrobeView_WardrobeModel_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
            UnknownVarFromWardrobeView_IItemListWindow_1 = null;
            UnknownVarFromWardrobeView_IItemListWindow_2.dispose();
            UnknownVarFromWardrobeView_IItemListWindow_2 = null;
            _slotTemplate.dispose();
            _slotTemplate = null;
         }
      }
      
      public function update() : void
      {
         var _loc4_:int = 0;
         var _loc2_:IItemListWindow = null;
         var _loc5_:WardrobeSlot = null;
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < UnknownVarFromWardrobeView_IItemListWindow_1.numListItems)
         {
            _loc2_ = UnknownVarFromWardrobeView_IItemListWindow_1.getListItemAt(_loc4_) as IItemListWindow;
            _loc2_.removeListItems();
            _loc4_ += 1;
         }
         var _loc1_:Array = UnknownVarFromWardrobeView_WardrobeModel_1.slots;
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc5_ = _loc1_[_loc3_];
            _loc4_ = _loc3_ / 7;
            _loc2_ = UnknownVarFromWardrobeView_IItemListWindow_1.getListItemAt(_loc4_) as IItemListWindow;
            if(_loc2_)
            {
               _loc2_.addListItem(_loc5_.view);
               _loc5_.view.visible = true;
            }
            _loc3_++;
         }
      }
      
      public function getWindowContainer() : IWindowController_1
      {
         return _window;
      }
   }
}

