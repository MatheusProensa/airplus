package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.sound.ISongInfo;
   import flash.geom.ColorTransform;
   
   public class PlayListEditorItemListView
   {
      private var UnknownVarFromPlayListEditorItemListView_IItemListWindow_1:IItemListWindow;
      
      private var _items:Array;
      
      private var UnknownVarFromPlayListEditorItemListView_PlayListEditorWidget_1:PlayListEditorWidget;
      
      private var UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1:PlayListEditorItem;
      
      private var _selectedItemIndex:int = -1;
      
      private var UnknownVarFromPlayListEditorItemListView_Int_1:int = -1;
      
      public function PlayListEditorItemListView(param1:PlayListEditorWidget, param2:IItemListWindow)
      {
         super();
         UnknownVarFromPlayListEditorItemListView_IItemListWindow_1 = param2;
         UnknownVarFromPlayListEditorItemListView_PlayListEditorWidget_1 = param1;
         UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1 = null;
      }
      
      public function get selectedItemIndex() : int
      {
         return _selectedItemIndex;
      }
      
      public function destroy() : void
      {
         if(UnknownVarFromPlayListEditorItemListView_IItemListWindow_1 == null)
         {
            return;
         }
         UnknownVarFromPlayListEditorItemListView_IItemListWindow_1.destroyListItems();
      }
      
      public function refresh(param1:Array, param2:int) : void
      {
         var _loc3_:String = null;
         var _loc7_:String = null;
         var _loc5_:ColorTransform = null;
         var _loc4_:PlayListEditorItem = null;
         if(UnknownVarFromPlayListEditorItemListView_IItemListWindow_1 == null)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         UnknownVarFromPlayListEditorItemListView_Int_1 = -1;
         _items = [];
         UnknownVarFromPlayListEditorItemListView_IItemListWindow_1.destroyListItems();
         for each(var _loc6_ in param1)
         {
            _loc3_ = _loc6_.name;
            _loc7_ = _loc6_.creator;
            _loc5_ = UnknownVarFromPlayListEditorItemListView_PlayListEditorWidget_1.getDiskColorTransformFromSongData(_loc6_.songData);
            _loc4_ = new PlayListEditorItem(UnknownVarFromPlayListEditorItemListView_PlayListEditorWidget_1,_loc3_,_loc7_,_loc5_);
            _loc4_.window.procedure = itemEventProc;
            _loc4_.removeButton.procedure = itemEventProc;
            UnknownVarFromPlayListEditorItemListView_IItemListWindow_1.addListItem(_loc4_.window);
            _items.push(_loc4_);
         }
         setItemIndexPlaying(param2);
      }
      
      public function setItemIndexPlaying(param1:int) : void
      {
         var _loc2_:PlayListEditorItem = null;
         if(_items == null)
         {
            return;
         }
         if(param1 < 0)
         {
            for each(var _loc3_ in _items)
            {
               _loc3_.setIconState("PLEI_ICON_STATE_NORMAL");
            }
            return;
         }
         if(param1 >= _items.length)
         {
            return;
         }
         if(UnknownVarFromPlayListEditorItemListView_Int_1 >= 0 && UnknownVarFromPlayListEditorItemListView_Int_1 < _items.length)
         {
            _loc2_ = _items[UnknownVarFromPlayListEditorItemListView_Int_1] as PlayListEditorItem;
            _loc2_.setIconState("PLEI_ICON_STATE_NORMAL");
         }
         _loc2_ = _items[param1] as PlayListEditorItem;
         _loc2_.setIconState("PLEI_ICON_STATE_PLAYING");
         UnknownVarFromPlayListEditorItemListView_Int_1 = param1;
      }
      
      public function deselectAny() : void
      {
         if(UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1 != null)
         {
            UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1.deselect();
            UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1 = null;
            _selectedItemIndex = -1;
         }
      }
      
      private function itemEventProc(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1.type == "WME_DOUBLE_CLICK";
         if(param1.type == "WME_CLICK" || _loc3_)
         {
            if(param2.name == "button_remove_from_playlist" || _loc3_)
            {
               if(UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1 != null)
               {
                  UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1.deselect();
               }
               if(_selectedItemIndex > -1)
               {
                  UnknownVarFromPlayListEditorItemListView_PlayListEditorWidget_1.sendRemoveFromPlayListMessage(_selectedItemIndex);
               }
               UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1 = null;
               _selectedItemIndex = -1;
            }
            else
            {
               if(UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1 != null)
               {
                  UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1.deselect();
               }
               _loc4_ = UnknownVarFromPlayListEditorItemListView_IItemListWindow_1.getListItemIndex(param1.window);
               if(_loc4_ != -1)
               {
                  _selectedItemIndex = _loc4_;
                  UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1 = _items[_loc4_];
                  UnknownVarFromPlayListEditorItemListView_PlayListEditorItem_1.select();
                  if(param2.name == "button_remove_from_playlist")
                  {
                     UnknownVarFromPlayListEditorItemListView_PlayListEditorWidget_1.sendRemoveFromPlayListMessage(_loc4_);
                  }
                  if(UnknownVarFromPlayListEditorItemListView_PlayListEditorWidget_1.mainWindowHandler != null)
                  {
                     UnknownVarFromPlayListEditorItemListView_PlayListEditorWidget_1.mainWindowHandler.musicInventoryView.deselectAny();
                  }
               }
            }
         }
      }
   }
}

