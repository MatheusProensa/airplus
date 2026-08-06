package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ITextWindow;
   
   public class HabbiconCollectionTrayView implements IComponentInterfaceQueue
   {
      private var UnknownVarFromHabbiconCollectionTrayView_HabbiconController_1:HabbiconController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromHabbiconCollectionTrayView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromHabbiconCollectionTrayView_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromHabbiconCollectionTrayView_Function_1:Function;
      
      private var UnknownVarFromHabbiconCollectionTrayView_Vector_1:Vector.<HabbiconCollectionTrayGroupView>;
      
      private var _disposed:Boolean;
      
      public function HabbiconCollectionTrayView(param1:HabbiconController, param2:IWindowController_1, param3:IWindowController_1, param4:IWindowController_1, param5:Function)
      {
         super();
         UnknownVarFromHabbiconCollectionTrayView_HabbiconController_1 = param1;
         _window = param2;
         UnknownVarFromHabbiconCollectionTrayView_IWindowController_1_1 = param3;
         UnknownVarFromHabbiconCollectionTrayView_IWindowController_1_2 = param4;
         UnknownVarFromHabbiconCollectionTrayView_Function_1 = param5;
         UnknownVarFromHabbiconCollectionTrayView_Vector_1 = new Vector.<HabbiconCollectionTrayGroupView>(0);
         removeTemplatesFromLayout();
      }
      
      public function refresh(param1:String, param2:Vector.<HabbiconSetModel>) : void
      {
         var _loc4_:HabbiconCollectionTrayGroupView = null;
         clearGroupViews();
         var _loc3_:* = param1 == "favourited";
         trayTitle.text = _loc3_ ? "${habbicon_book.tab.favourited}" : "${habbicon_book.tab.owned}";
         traySummary.text = resolveSummaryText(_loc3_,param2);
         if(param2 != null)
         {
            for each(var _loc5_ in param2)
            {
               if(_loc5_ != null)
               {
                  _loc4_ = new HabbiconCollectionTrayGroupView(UnknownVarFromHabbiconCollectionTrayView_IWindowController_1_1,UnknownVarFromHabbiconCollectionTrayView_IWindowController_1_2,UnknownVarFromHabbiconCollectionTrayView_HabbiconController_1,UnknownVarFromHabbiconCollectionTrayView_Function_1);
                  _loc4_.initialize(_loc5_);
                  trayGroupList.addListItem(_loc4_.window);
                  UnknownVarFromHabbiconCollectionTrayView_Vector_1.push(_loc4_);
               }
            }
         }
         trayGroupList.scrollV = 0;
         _window.visible = true;
      }
      
      public function refreshEntry(param1:HabbiconEntryModel) : void
      {
         if(param1 == null)
         {
            return;
         }
         for each(var _loc2_ in UnknownVarFromHabbiconCollectionTrayView_Vector_1)
         {
            if(matchesEntryGroup(_loc2_.group,param1))
            {
               _loc2_.refreshEntry(param1);
               return;
            }
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         clearGroupViews();
         UnknownVarFromHabbiconCollectionTrayView_HabbiconController_1 = null;
         _window = null;
         UnknownVarFromHabbiconCollectionTrayView_IWindowController_1_1 = null;
         UnknownVarFromHabbiconCollectionTrayView_IWindowController_1_2 = null;
         UnknownVarFromHabbiconCollectionTrayView_Function_1 = null;
         UnknownVarFromHabbiconCollectionTrayView_Vector_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function clearGroupViews() : void
      {
         for each(var _loc1_ in UnknownVarFromHabbiconCollectionTrayView_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromHabbiconCollectionTrayView_Vector_1.length = 0;
      }
      
      private function removeTemplatesFromLayout() : void
      {
         if(trayGroupList.getListItemIndex(UnknownVarFromHabbiconCollectionTrayView_IWindowController_1_1) > -1)
         {
            trayGroupList.removeListItem(UnknownVarFromHabbiconCollectionTrayView_IWindowController_1_1);
         }
      }
      
      private function resolveSummaryText(param1:Boolean, param2:Vector.<HabbiconSetModel>) : String
      {
         if(param2 == null || param2.length == 0)
         {
            return param1 ? "${habbicon_book.tray.empty.favourited}" : "${habbicon_book.tray.empty.owned}";
         }
         return UnknownVarFromHabbiconCollectionTrayView_HabbiconController_1.localizationManager.getLocalizationWithParams(param1 ? "habbicon_book.tray.favourited.summary" : "habbicon_book.tray.owned.summary","","count",countEntries(param2));
      }
      
      private function countEntries(param1:Vector.<HabbiconSetModel>) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in param1)
         {
            if(_loc3_ != null && _loc3_.habbicons != null)
            {
               _loc2_ += _loc3_.habbicons.length;
            }
         }
         return _loc2_;
      }
      
      private function matchesEntryGroup(param1:HabbiconSetModel, param2:HabbiconEntryModel) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param1.collectionId == param2.collectionId)
         {
            return true;
         }
         return param2.collectionTitle != null && param1.title == param2.collectionTitle;
      }
      
      private function get trayTitle() : ITextWindow
      {
         return _window.findChildByName("tray_title") as ITextWindow;
      }
      
      private function get traySummary() : ITextWindow
      {
         return _window.findChildByName("tray_summary") as ITextWindow;
      }
      
      private function get trayGroupList() : IItemListWindow
      {
         return _window.findChildByName("tray_group_list") as IItemListWindow;
      }
   }
}

