package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
   import com.sulake.habbo.communication.messages.incoming.talent.TalentLevelUpMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.talent.TalentTrackLevelMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackLevelMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   import com.sulake.habbo.communication.messages.parser.talent.TalentLevelUpMessageParser;
   import com.sulake.habbo.communication.messages.parser.talent.TalentTrackLevelMessageParser;
   
   public class TalentPromoCtrl implements IComponentInterfaceQueue
   {
      private static const BG_COLOR_LIGHT:uint = 4286084205;
      
      private static const BG_COLOR_DARK:uint = 4283781966;
      
      private var UnknownVarFromTalentPromoCtrl_HabboTalent_1:HabboTalent;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromTalentPromoCtrl_Int_1:int;
      
      private var UnknownVarFromTalentPromoCtrl_Int_2:int;
      
      private var UnknownVarFromTalentPromoCtrl_Int_3:int;
      
      public function TalentPromoCtrl(param1:HabboTalent)
      {
         super();
         UnknownVarFromTalentPromoCtrl_HabboTalent_1 = param1;
      }
      
      public function dispose() : void
      {
         if(toolbarAttachAllowed())
         {
            UnknownVarFromTalentPromoCtrl_HabboTalent_1.toolbar.extensionView.detachExtension("talent_promo");
         }
         UnknownVarFromTalentPromoCtrl_HabboTalent_1 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get disposed() : Boolean
      {
         return UnknownVarFromTalentPromoCtrl_HabboTalent_1 == null;
      }
      
      public function initialize() : void
      {
         if(!enabled)
         {
            return;
         }
         UnknownVarFromTalentPromoCtrl_HabboTalent_1.communicationManager.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
         UnknownVarFromTalentPromoCtrl_HabboTalent_1.communicationManager.addHabboConnectionMessageEvent(new TalentLevelUpMessageEvent(onTalentLevelUp));
         UnknownVarFromTalentPromoCtrl_HabboTalent_1.communicationManager.addHabboConnectionMessageEvent(new TalentTrackLevelMessageEvent(onTalentTrackLevel));
      }
      
      private function onUserObject(param1:UserObjectEvent) : void
      {
         UnknownVarFromTalentPromoCtrl_HabboTalent_1.send(new GetTalentTrackLevelMessageComposer(promotedTalentTrack));
      }
      
      private function onTalentTrackLevel(param1:TalentTrackLevelMessageEvent) : void
      {
         var _loc2_:TalentTrackLevelMessageParser = param1.getParser();
         if(_loc2_.talentTrackName == promotedTalentTrack)
         {
            UnknownVarFromTalentPromoCtrl_Int_2 = _loc2_.maxLevel;
            UnknownVarFromTalentPromoCtrl_Int_1 = _loc2_.level;
            refresh();
         }
      }
      
      private function onTalentLevelUp(param1:TalentLevelUpMessageEvent) : void
      {
         var _loc2_:TalentLevelUpMessageParser = param1.getParser();
         if(_loc2_.talentTrackName == promotedTalentTrack)
         {
            UnknownVarFromTalentPromoCtrl_Int_1 = _loc2_.level;
            refresh();
         }
      }
      
      private function refresh() : void
      {
         if(!enabled || maxLevelReached)
         {
            close();
            return;
         }
         prepareWindow();
         setText("title");
         _window.x = 0;
         _window.y = 0;
         if(toolbarAttachAllowed())
         {
            UnknownVarFromTalentPromoCtrl_HabboTalent_1.toolbar.extensionView.attachExtension("talent_promo",_window,7);
         }
      }
      
      private function setText(param1:String) : void
      {
         _window.findChildByName(param1 + "_txt").caption = "${talentpromo." + promotedTalentTrack + "." + param1 + "}";
      }
      
      private function prepareWindow() : void
      {
         if(this._window != null)
         {
            return;
         }
         _window = IWindowController_1(UnknownVarFromTalentPromoCtrl_HabboTalent_1.getXmlWindow("track_promo"));
         _window.addEventListener("WME_CLICK",onCheckProgress);
         _window.addEventListener("WME_OVER",onContainerMouseOver);
         _window.addEventListener("WME_OUT",onContainerMouseOut);
         UnknownVarFromTalentPromoCtrl_Int_3 = _window.height;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            if(toolbarAttachAllowed())
            {
               UnknownVarFromTalentPromoCtrl_HabboTalent_1.toolbar.extensionView.detachExtension("talent_promo");
            }
         }
      }
      
      private function onCheckProgress(param1:WindowEvent, param2:IWindowModel = null) : void
      {
         if(param1.type == "WME_CLICK" && enabled)
         {
            UnknownVarFromTalentPromoCtrl_HabboTalent_1.tracking.trackTalentTrackOpen(promotedTalentTrack,"talentpromo");
            UnknownVarFromTalentPromoCtrl_HabboTalent_1.send(new GetTalentTrackMessageComposer(promotedTalentTrack));
         }
      }
      
      private function toolbarAttachAllowed() : Boolean
      {
         return UnknownVarFromTalentPromoCtrl_HabboTalent_1 != null && UnknownVarFromTalentPromoCtrl_HabboTalent_1.toolbar != null && UnknownVarFromTalentPromoCtrl_HabboTalent_1.toolbar.extensionView != null && enabled;
      }
      
      private function get enabled() : Boolean
      {
         return promotedTalentTrack != "";
      }
      
      private function get promotedTalentTrack() : String
      {
         return UnknownVarFromTalentPromoCtrl_HabboTalent_1.getProperty("talentpromo.track");
      }
      
      private function get maxLevelReached() : Boolean
      {
         return UnknownVarFromTalentPromoCtrl_Int_1 >= UnknownVarFromTalentPromoCtrl_Int_2;
      }
      
      private function onContainerMouseOver(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = 4286084205;
      }
      
      private function onContainerMouseOut(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = 4283781966;
      }
   }
}

