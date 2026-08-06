package com.sulake.habbo.groups.badge_leaderboard
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   
   public class BadgeLeaderboardEntryView implements IComponentInterfaceQueue
   {
      private var _disposed:Boolean;
      
      private var UnknownVarFromBadgeLeaderboardEntryView_Boolean_1:Boolean;
      
      private var _rankTextName:String;
      
      private var _window:IWindowController_1;
      
      public function BadgeLeaderboardEntryView(param1:IWindowController_1, param2:Boolean = true, param3:String = "rank_number")
      {
         super();
         UnknownVarFromBadgeLeaderboardEntryView_Boolean_1 = param2;
         _rankTextName = param3;
         _window = param1;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromBadgeLeaderboardEntryView_Boolean_1)
         {
            _window.dispose();
         }
         _window = null;
         _rankTextName = null;
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
      
      public function get evenBackground() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("entry_bg_even") as IStaticBitmapWrapperWindow;
      }
      
      public function get unevenBackground() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("entry_bg_uneven") as IStaticBitmapWrapperWindow;
      }
      
      public function get rankText() : ITextWindow
      {
         return _window.findChildByName(_rankTextName) as ITextWindow;
      }
      
      public function get rankBorder() : UnknownICoreWindowComponents6
      {
         return _window.findChildByName("rank_border") as UnknownICoreWindowComponents6;
      }
      
      public function get profileRegion() : IRegionWindow
      {
         return _window.findChildByName("region_profile") as IRegionWindow;
      }
      
      public function get profileCanvas() : IBitmapWrapperController
      {
         return _window.findChildByName("canvas") as IBitmapWrapperController;
      }
      
      public function get usernameText() : ITextWindow
      {
         return _window.findChildByName("username_txt") as ITextWindow;
      }
      
      public function get scoreText() : ITextWindow
      {
         return _window.findChildByName("score_txt") as ITextWindow;
      }
      
      public function get rankTypeImage() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("rank_type_img") as IStaticBitmapWrapperWindow;
      }
   }
}

