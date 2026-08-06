package com.sulake.habbo.catalog.habbicons
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.ITextWindow;
   
   public class HabbiconAlbumHeaderView implements IComponentInterfaceQueue
   {
      private var UnknownVarFromHabbiconAlbumHeaderView_HabbiconController_1:HabbiconController;
      
      private var _window:IWindowController_1;
      
      private var _progressView:HabbiconProgressBarView;
      
      private var _disposed:Boolean;
      
      public function HabbiconAlbumHeaderView(param1:HabbiconController, param2:IWindowController_1)
      {
         super();
         UnknownVarFromHabbiconAlbumHeaderView_HabbiconController_1 = param1;
         _window = param2;
         _progressView = new HabbiconProgressBarView(albumProgressBar);
      }
      
      public function refresh(param1:HabbiconAlbumStats, param2:Boolean) : void
      {
         _progressView.setRatio(param1.progressRatio,param2);
         albumProgressText.text = UnknownVarFromHabbiconAlbumHeaderView_HabbiconController_1.localizationManager.getLocalizationWithParams("habbicon_book.album_progress.count","","collected",param1.collected,"total",param1.total);
         ownedHabbiconsValue.text = String(param1.ownedHabbicons);
         setsCompletedValue.text = String(param1.completedSets);
      }
      
      public function update(param1:uint) : void
      {
         _progressView.update(param1);
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_progressView != null)
         {
            _progressView.dispose();
            _progressView = null;
         }
         UnknownVarFromHabbiconAlbumHeaderView_HabbiconController_1 = null;
         _window = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get albumProgressBar() : IWindowController_1
      {
         return _window.findChildByName("album_progress_bar") as IWindowController_1;
      }
      
      private function get albumProgressText() : ITextWindow
      {
         return _window.findChildByName("album_progress_text") as ITextWindow;
      }
      
      private function get ownedHabbiconsValue() : ITextWindow
      {
         return _window.findChildByName("owned_habbicons_value") as ITextWindow;
      }
      
      private function get setsCompletedValue() : ITextWindow
      {
         return _window.findChildByName("sets_completed_value") as ITextWindow;
      }
   }
}

