package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   
   public class HabbiconCollectionTrayGroupView implements IComponentInterfaceQueue
   {
      private static const BOTTOM_PADDING:int = 8;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromHabbiconCollectionTrayGroupView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromHabbiconCollectionTrayGroupView_HabbiconController_1:HabbiconController;
      
      private var UnknownVarFromHabbiconCollectionTrayGroupView_Function_1:Function;
      
      private var _group:HabbiconSetModel;
      
      private var _tiles:Vector.<HabbiconTileView>;
      
      private var _baseHeight:int;
      
      private var UnknownVarFromHabbiconCollectionTrayGroupView_Int_1:int;
      
      private var _disposed:Boolean;
      
      public function HabbiconCollectionTrayGroupView(param1:IWindowController_1, param2:IWindowController_1, param3:HabbiconController, param4:Function)
      {
         super();
         _window = param1.clone() as IWindowController_1;
         UnknownVarFromHabbiconCollectionTrayGroupView_IWindowController_1_1 = param2;
         UnknownVarFromHabbiconCollectionTrayGroupView_HabbiconController_1 = param3;
         UnknownVarFromHabbiconCollectionTrayGroupView_Function_1 = param4;
         _tiles = new Vector.<HabbiconTileView>(0);
         _baseHeight = _window.height;
         UnknownVarFromHabbiconCollectionTrayGroupView_Int_1 = trayGroupGrid.height;
         removeClonedTileTemplate();
      }
      
      public function initialize(param1:HabbiconSetModel) : void
      {
         var _loc3_:HabbiconTileView = null;
         _group = param1;
         recycleTiles();
         trayGroupTitle.text = param1.title;
         _window.visible = true;
         for each(var _loc2_ in param1.habbicons)
         {
            _loc3_ = HabbiconTileView.claim(UnknownVarFromHabbiconCollectionTrayGroupView_IWindowController_1_1);
            _loc3_.initialize(UnknownVarFromHabbiconCollectionTrayGroupView_HabbiconController_1,_loc2_,UnknownVarFromHabbiconCollectionTrayGroupView_Function_1);
            trayGroupGrid.addGridItem(_loc3_.window);
            _tiles.push(_loc3_);
         }
         resizeToContent();
      }
      
      public function refreshEntry(param1:HabbiconEntryModel) : void
      {
         if(param1 == null)
         {
            return;
         }
         for each(var _loc2_ in _tiles)
         {
            if(_loc2_.item != null && _loc2_.item.habbiconId == param1.habbiconId)
            {
               _loc2_.refresh(param1);
               return;
            }
         }
      }
      
      public function recycle() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_window.parent != null)
         {
            (_window.parent as IWindowController_1).removeChild(_window);
         }
         recycleTiles();
         _group = null;
         _window.visible = false;
         trayGroupGrid.height = UnknownVarFromHabbiconCollectionTrayGroupView_Int_1;
         _window.height = _baseHeight;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         recycle();
         _window.dispose();
         _window = null;
         UnknownVarFromHabbiconCollectionTrayGroupView_IWindowController_1_1 = null;
         UnknownVarFromHabbiconCollectionTrayGroupView_HabbiconController_1 = null;
         UnknownVarFromHabbiconCollectionTrayGroupView_Function_1 = null;
         _group = null;
         _tiles = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get window() : IWindowController_1
      {
         return _window;
      }
      
      public function get group() : HabbiconSetModel
      {
         return _group;
      }
      
      private function recycleTiles() : void
      {
         trayGroupGrid.removeGridItems();
         for each(var _loc1_ in _tiles)
         {
            HabbiconTileView.release(_loc1_);
         }
         _tiles.length = 0;
      }
      
      private function removeClonedTileTemplate() : void
      {
         var _loc2_:IWindowController_1 = null;
         var _loc1_:IWindowModel = trayTileTemplate;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc3_:IItemListWindow = _loc1_.parent as IItemListWindow;
         if(_loc3_ != null)
         {
            _loc3_.removeListItem(_loc1_);
         }
         else if(_loc1_.parent != null)
         {
            _loc2_ = _loc1_.parent as IWindowController_1;
            if(_loc2_ != null)
            {
               _loc2_.removeChild(_loc1_);
            }
         }
         _loc1_.dispose();
      }
      
      private function resizeToContent() : void
      {
         trayGroupGrid.height = Math.max(UnknownVarFromHabbiconCollectionTrayGroupView_Int_1,trayGroupGrid.scrollableRegion.height);
         _window.height = Math.max(_baseHeight,trayGroupGrid.y + trayGroupGrid.height + 8);
         _window.invalidate();
      }
      
      private function get trayGroupTitle() : ITextWindow
      {
         return _window.findChildByName("tray_group_title") as ITextWindow;
      }
      
      private function get trayGroupGrid() : IItemGridWindow
      {
         return _window.findChildByName("tray_group_grid") as IItemGridWindow;
      }
      
      private function get trayTileTemplate() : IWindowModel
      {
         return trayGroupGrid.getGridItemByName("tray_tile_template");
      }
   }
}

