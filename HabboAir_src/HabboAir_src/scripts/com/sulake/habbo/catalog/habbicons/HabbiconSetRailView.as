package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemListWindow;
   
   public class HabbiconSetRailView implements IComponentInterfaceQueue
   {
      private var _window:IWindowController_1;
      
      private var UnknownVarFromHabbiconSetRailView_IWindowController_1_1:IWindowController_1;
      
      private var UnknownVarFromHabbiconSetRailView_Vector_1:Vector.<HabbiconSetRailRowView>;
      
      private var UnknownVarFromHabbiconSetRailView_HabbiconSetModel_1:HabbiconSetModel;
      
      private var UnknownVarFromHabbiconSetRailView_Function_1:Function;
      
      private var _disposed:Boolean;
      
      public function HabbiconSetRailView(param1:IWindowController_1, param2:Function)
      {
         super();
         _window = param1;
         UnknownVarFromHabbiconSetRailView_Function_1 = param2;
         UnknownVarFromHabbiconSetRailView_Vector_1 = new Vector.<HabbiconSetRailRowView>(0);
         UnknownVarFromHabbiconSetRailView_IWindowController_1_1 = setRailList.removeListItem(setRailList.getListItemByName("set_row_template")) as IWindowController_1;
      }
      
      public function setSets(param1:Vector.<HabbiconSetModel>) : void
      {
         var _loc3_:HabbiconSetRailRowView = null;
         clearRows();
         for each(var _loc2_ in param1)
         {
            _loc3_ = new HabbiconSetRailRowView(UnknownVarFromHabbiconSetRailView_IWindowController_1_1,UnknownVarFromHabbiconSetRailView_Function_1);
            _loc3_.initialize(_loc2_);
            _loc3_.setActive(_loc3_.set == UnknownVarFromHabbiconSetRailView_HabbiconSetModel_1);
            setRailList.addListItem(_loc3_.window);
            UnknownVarFromHabbiconSetRailView_Vector_1.push(_loc3_);
         }
      }
      
      public function setActiveSet(param1:HabbiconSetModel) : void
      {
         UnknownVarFromHabbiconSetRailView_HabbiconSetModel_1 = param1;
         for each(var _loc2_ in UnknownVarFromHabbiconSetRailView_Vector_1)
         {
            _loc2_.setActive(_loc2_.set == param1);
         }
      }
      
      public function refreshSet(param1:HabbiconSetModel, param2:Boolean) : void
      {
         for each(var _loc3_ in UnknownVarFromHabbiconSetRailView_Vector_1)
         {
            if(_loc3_.set == param1 || _loc3_.set.collectionId == param1.collectionId)
            {
               _loc3_.refreshProgress(param2);
               return;
            }
         }
      }
      
      public function update(param1:uint) : void
      {
         for each(var _loc2_ in UnknownVarFromHabbiconSetRailView_Vector_1)
         {
            _loc2_.update(param1);
         }
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         clearRows();
         UnknownVarFromHabbiconSetRailView_IWindowController_1_1.dispose();
         UnknownVarFromHabbiconSetRailView_IWindowController_1_1 = null;
         _window = null;
         UnknownVarFromHabbiconSetRailView_HabbiconSetModel_1 = null;
         UnknownVarFromHabbiconSetRailView_Function_1 = null;
         UnknownVarFromHabbiconSetRailView_Vector_1 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function clearRows() : void
      {
         for each(var _loc1_ in UnknownVarFromHabbiconSetRailView_Vector_1)
         {
            _loc1_.dispose();
         }
         UnknownVarFromHabbiconSetRailView_Vector_1.length = 0;
      }
      
      private function get setRailList() : IItemListWindow
      {
         return _window.findChildByName("set_rail_list") as IItemListWindow;
      }
   }
}

