package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.habbo.communication.messages.parser.talent.TalentTrack;
   import com.sulake.habbo.utils.UnknownHabboUtils1;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   
   public class TalentProgressMeter implements IComponentInterfaceQueue
   {
      private const ACHIEVED_DIVIDER:String = "talent_achieved_div";
      
      private const UNACHIEVED_DIVIDER:String = "talent_unachieved_div";
      
      private const DIVIDER_WINDOW_PREFIX:String = "progress_divider_level_";
      
      private const AVATAR_GLOW_RADIUS:int = 10;
      
      private var _disposed:Boolean = false;
      
      private var _habboTalent:HabboTalent;
      
      private var UnknownVarFromTalentProgressMeter_TalentTrackController_1:TalentTrackController;
      
      private var _talentTrack:TalentTrack;
      
      private var UnknownVarFromTalentProgressMeter_IWindowController_1_1:IWindowController_1;
      
      private var _divider:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromTalentProgressMeter_IWidgetWindowController_1:IWidgetWindowController;
      
      private var UnknownVarFromTalentProgressMeter_IStaticBitmapWrapperWindow_1:IStaticBitmapWrapperWindow;
      
      private var UnknownVarFromTalentProgressMeter_IStaticBitmapWrapperWindow_2:IStaticBitmapWrapperWindow;
      
      public function TalentProgressMeter(param1:HabboTalent, param2:TalentTrackController)
      {
         super();
         _habboTalent = param1;
         UnknownVarFromTalentProgressMeter_TalentTrackController_1 = param2;
         _talentTrack = UnknownVarFromTalentProgressMeter_TalentTrackController_1.talentTrack;
         createMeter();
      }
      
      public function get width() : int
      {
         return UnknownVarFromTalentProgressMeter_TalentTrackController_1.window.width;
      }
      
      public function get progressPerLevelWidth() : int
      {
         return int(Math.floor(UnknownHabboUtils1.lerp(_talentTrack.progressPerLevel,0,width)));
      }
      
      private function createMeter() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IStaticBitmapWrapperWindow = null;
         UnknownVarFromTalentProgressMeter_IWindowController_1_1 = IWindowController_1(UnknownVarFromTalentProgressMeter_TalentTrackController_1.window.findChildByName("progress_container"));
         _divider = IStaticBitmapWrapperWindow(UnknownVarFromTalentProgressMeter_IWindowController_1_1.removeChild(UnknownVarFromTalentProgressMeter_IWindowController_1_1.findChildByName("progress_level_divider")));
         UnknownVarFromTalentProgressMeter_IStaticBitmapWrapperWindow_1 = IStaticBitmapWrapperWindow(UnknownVarFromTalentProgressMeter_IWindowController_1_1.findChildByName("achieved_mid"));
         UnknownVarFromTalentProgressMeter_IStaticBitmapWrapperWindow_2 = IStaticBitmapWrapperWindow(UnknownVarFromTalentProgressMeter_IWindowController_1_1.findChildByName("unachieved_mid"));
         _loc2_ = 1;
         while(_loc2_ < _talentTrack.levels.length)
         {
            _loc1_ = IStaticBitmapWrapperWindow(_divider.clone());
            _loc1_.name = "progress_divider_level_" + _loc2_;
            UnknownVarFromTalentProgressMeter_IWindowController_1_1.addChild(_loc1_);
            _loc2_++;
         }
         UnknownVarFromTalentProgressMeter_IWidgetWindowController_1 = IWidgetWindowController(UnknownVarFromTalentProgressMeter_IWindowController_1_1.findChildByName("progress_needle"));
         IAvatarImageWidget(UnknownVarFromTalentProgressMeter_IWidgetWindowController_1.widget).figure = _habboTalent.sessionManager.figure;
         UnknownVarFromTalentProgressMeter_IWindowController_1_1.setChildIndex(UnknownVarFromTalentProgressMeter_IWidgetWindowController_1,UnknownVarFromTalentProgressMeter_IWindowController_1_1.numChildren - 1);
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_divider)
            {
               _divider.dispose();
               _divider = null;
            }
            UnknownVarFromTalentProgressMeter_IStaticBitmapWrapperWindow_1 = null;
            UnknownVarFromTalentProgressMeter_IStaticBitmapWrapperWindow_2 = null;
            UnknownVarFromTalentProgressMeter_IWidgetWindowController_1 = null;
            UnknownVarFromTalentProgressMeter_IWindowController_1_1 = null;
            _talentTrack = null;
            UnknownVarFromTalentProgressMeter_TalentTrackController_1 = null;
            _habboTalent = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function resize() : void
      {
         var _loc5_:int = 0;
         var _loc4_:IStaticBitmapWrapperWindow = null;
         var _loc1_:int = Math.floor(UnknownHabboUtils1.lerp(_talentTrack.totalProgress,0,width));
         UnknownVarFromTalentProgressMeter_IWindowController_1_1.width = width;
         UnknownVarFromTalentProgressMeter_IStaticBitmapWrapperWindow_2.width = width;
         UnknownVarFromTalentProgressMeter_IStaticBitmapWrapperWindow_1.width = _loc1_;
         UnknownVarFromTalentProgressMeter_IWidgetWindowController_1.x = UnknownHabboUtils1.clamp(_loc1_ - int(UnknownVarFromTalentProgressMeter_IWidgetWindowController_1.width / 2),0,width - UnknownVarFromTalentProgressMeter_IWidgetWindowController_1.width);
         var _loc2_:IWindowModel = UnknownVarFromTalentProgressMeter_IWindowController_1_1.findChildByName("avatar_glow");
         _loc2_.x = UnknownVarFromTalentProgressMeter_IWidgetWindowController_1.x - 10;
         _loc2_.y = UnknownVarFromTalentProgressMeter_IWidgetWindowController_1.y - 10;
         _loc2_.width = UnknownVarFromTalentProgressMeter_IWidgetWindowController_1.width + 2 * 10;
         _loc2_.height = UnknownVarFromTalentProgressMeter_IWidgetWindowController_1.height + 2 * 10;
         var _loc3_:IWindowModel = UnknownVarFromTalentProgressMeter_IWindowController_1_1.findChildByName("progress_balloon");
         _loc3_.x = UnknownVarFromTalentProgressMeter_IWidgetWindowController_1.x + Math.floor(UnknownVarFromTalentProgressMeter_IWidgetWindowController_1.width / 2) - Math.floor(_loc3_.width / 2) + 5;
         _loc5_ = 1;
         while(_loc5_ < _talentTrack.levels.length)
         {
            _loc4_ = IStaticBitmapWrapperWindow(UnknownVarFromTalentProgressMeter_IWindowController_1_1.findChildByName("progress_divider_level_" + _loc5_));
            _loc4_.x = _loc5_ * progressPerLevelWidth;
            if(_loc4_.x < _loc1_)
            {
               _loc4_.assetUri = "talent_achieved_div";
            }
            else
            {
               _loc4_.assetUri = "talent_unachieved_div";
            }
            _loc4_.visible = true;
            _loc5_++;
         }
         UnknownVarFromTalentProgressMeter_IWindowController_1_1.invalidate();
      }
   }
}

