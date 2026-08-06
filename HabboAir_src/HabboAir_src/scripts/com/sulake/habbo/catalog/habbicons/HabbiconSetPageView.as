package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   
   public class HabbiconSetPageView implements IComponentInterfaceQueue
   {
      private static const VISIBLE_SLOT_COUNT:int = 20;
      
      private var UnknownVarFromHabbiconSetPageView_HabbiconController_1:HabbiconController;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromHabbiconSetPageView_IWindowController_1_1:IWindowController_1;
      
      private var _emptyTileTemplate:IWindowController_1;
      
      private var UnknownVarFromHabbiconSetPageView_Function_1:Function;
      
      private var UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1:HabbiconSetModel;
      
      private var _progressView:HabbiconProgressBarView;
      
      private var UnknownVarFromHabbiconSetPageView_HabbiconRewardPanelView_1:HabbiconRewardPanelView;
      
      private var _tiles:Vector.<HabbiconTileView>;
      
      private var _emptySlots:Vector.<IWindowController_1>;
      
      private var _disposed:Boolean;
      
      public function HabbiconSetPageView(param1:HabbiconController, param2:IWindowController_1, param3:IWindowController_1, param4:IWindowController_1, param5:Function)
      {
         super();
         UnknownVarFromHabbiconSetPageView_HabbiconController_1 = param1;
         _window = param2;
         UnknownVarFromHabbiconSetPageView_IWindowController_1_1 = param3;
         _emptyTileTemplate = param4;
         UnknownVarFromHabbiconSetPageView_Function_1 = param5;
         _progressView = new HabbiconProgressBarView(setProgressBar);
         UnknownVarFromHabbiconSetPageView_HabbiconRewardPanelView_1 = new HabbiconRewardPanelView(UnknownVarFromHabbiconSetPageView_HabbiconController_1,_window,UnknownVarFromHabbiconSetPageView_Function_1);
         _tiles = new Vector.<HabbiconTileView>(0);
         _emptySlots = new Vector.<IWindowController_1>(0);
      }
      
      public function refresh(param1:HabbiconSetModel, param2:Boolean) : void
      {
         var _loc4_:HabbiconTileView = null;
         UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1 = param1;
         recycleTiles();
         if(UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1 == null)
         {
            _window.visible = false;
            setTitle.text = "";
            setDescription.text = "";
            _progressView.setRatio(0,false);
            setProgressText.text = "";
            UnknownVarFromHabbiconSetPageView_HabbiconRewardPanelView_1.refresh(null,false);
            return;
         }
         _window.visible = true;
         setTitle.text = UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1.title;
         setDescription.text = UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1.description;
         _progressView.setRatio(UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1.progressRatio,param2);
         setProgressText.text = UnknownVarFromHabbiconSetPageView_HabbiconController_1.localizationManager.getLocalizationWithParams("habbicon_book.set_progress.count","","collected",UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1.completed,"total",UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1.total);
         for each(var _loc3_ in UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1.habbicons)
         {
            _loc4_ = HabbiconTileView.claim(UnknownVarFromHabbiconSetPageView_IWindowController_1_1);
            _loc4_.initialize(UnknownVarFromHabbiconSetPageView_HabbiconController_1,_loc3_,UnknownVarFromHabbiconSetPageView_Function_1);
            setGrid.addGridItem(_loc4_.window);
            _tiles.push(_loc4_);
         }
         addEmptySlots(_tiles.length);
         UnknownVarFromHabbiconSetPageView_HabbiconRewardPanelView_1.refresh(UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1,param2);
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
      
      public function refreshProgress(param1:HabbiconSetModel, param2:Boolean) : void
      {
         UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1 = param1;
         if(UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1 == null)
         {
            _progressView.setRatio(0,false);
            setProgressText.text = "";
            return;
         }
         _progressView.setRatio(UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1.progressRatio,param2);
         setProgressText.text = UnknownVarFromHabbiconSetPageView_HabbiconController_1.localizationManager.getLocalizationWithParams("habbicon_book.set_progress.count","","collected",UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1.completed,"total",UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1.total);
      }
      
      public function refreshReward(param1:HabbiconSetModel, param2:Boolean) : void
      {
         UnknownVarFromHabbiconSetPageView_HabbiconRewardPanelView_1.refresh(param1,param2);
      }
      
      public function update(param1:uint) : void
      {
         _progressView.update(param1);
         UnknownVarFromHabbiconSetPageView_HabbiconRewardPanelView_1.update(param1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         recycleTiles();
         if(_progressView != null)
         {
            _progressView.dispose();
            _progressView = null;
         }
         if(UnknownVarFromHabbiconSetPageView_HabbiconRewardPanelView_1 != null)
         {
            UnknownVarFromHabbiconSetPageView_HabbiconRewardPanelView_1.dispose();
            UnknownVarFromHabbiconSetPageView_HabbiconRewardPanelView_1 = null;
         }
         UnknownVarFromHabbiconSetPageView_HabbiconController_1 = null;
         _window = null;
         UnknownVarFromHabbiconSetPageView_IWindowController_1_1 = null;
         _emptyTileTemplate = null;
         UnknownVarFromHabbiconSetPageView_Function_1 = null;
         UnknownVarFromHabbiconSetPageView_HabbiconSetModel_1 = null;
         _tiles = null;
         _emptySlots = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function recycleTiles() : void
      {
         setGrid.removeGridItems();
         for each(var _loc2_ in _tiles)
         {
            HabbiconTileView.release(_loc2_);
         }
         _tiles.length = 0;
         for each(var _loc1_ in _emptySlots)
         {
            _loc1_.dispose();
         }
         _emptySlots.length = 0;
      }
      
      private function addEmptySlots(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:IWindowController_1 = null;
         var _loc2_:int = Math.max(0,20 - param1);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _emptyTileTemplate.clone() as IWindowController_1;
            _loc3_.visible = true;
            setGrid.addGridItem(_loc3_);
            _emptySlots.push(_loc3_);
            _loc4_++;
         }
      }
      
      private function get setTitle() : ITextWindow
      {
         return _window.findChildByName("set_title") as ITextWindow;
      }
      
      private function get setDescription() : ITextWindow
      {
         return _window.findChildByName("set_description") as ITextWindow;
      }
      
      private function get setProgressBar() : IWindowController_1
      {
         return _window.findChildByName("set_progress_bar") as IWindowController_1;
      }
      
      private function get setProgressText() : ITextWindow
      {
         return _window.findChildByName("set_progress_text") as ITextWindow;
      }
      
      private function get setGrid() : IItemGridWindow
      {
         return _window.findChildByName("set_grid") as IItemGridWindow;
      }
   }
}

