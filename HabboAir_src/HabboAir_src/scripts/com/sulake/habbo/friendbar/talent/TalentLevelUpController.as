package com.sulake.habbo.friendbar.talent
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.talent.TalentLevelUpMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
   import com.sulake.habbo.communication.messages.parser.talent.TalentLevelUpMessageParser;
   import com.sulake.habbo.communication.messages.parser.talent.TalentTrackRewardPerk;
   import com.sulake.habbo.communication.messages.parser.talent.TalentTrackRewardProduct;
   import com.sulake.habbo.window.widgets.IBadgeImageWidget;
   
   public class TalentLevelUpController implements IComponentInterfaceQueue
   {
      private var _habboTalent:HabboTalent;
      
      private var _disposed:Boolean;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromTalentLevelUpController_String_1:String;
      
      private var UnknownVarFromTalentLevelUpController_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromTalentLevelUpController_IWindowModel_2:IWindowModel;
      
      private var UnknownVarFromTalentLevelUpController_IWindowModel_3:IWindowModel;
      
      public function TalentLevelUpController(param1:HabboTalent)
      {
         super();
         _habboTalent = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(UnknownVarFromTalentLevelUpController_IWindowModel_3 != null)
            {
               UnknownVarFromTalentLevelUpController_IWindowModel_3.dispose();
               UnknownVarFromTalentLevelUpController_IWindowModel_3 = null;
            }
            if(UnknownVarFromTalentLevelUpController_IWindowModel_1 != null)
            {
               UnknownVarFromTalentLevelUpController_IWindowModel_1.dispose();
               UnknownVarFromTalentLevelUpController_IWindowModel_1 = null;
            }
            if(UnknownVarFromTalentLevelUpController_IWindowModel_2 != null)
            {
               UnknownVarFromTalentLevelUpController_IWindowModel_2.dispose();
               UnknownVarFromTalentLevelUpController_IWindowModel_2 = null;
            }
            closeWindow();
            _habboTalent = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function initialize() : void
      {
         _habboTalent.communicationManager.addHabboConnectionMessageEvent(new TalentLevelUpMessageEvent(onTalentLevelUp));
      }
      
      private function onTalentLevelUp(param1:TalentLevelUpMessageEvent) : void
      {
         var _loc2_:TalentLevelUpMessageParser = param1.getParser();
         if(_loc2_.level == 1 && _loc2_.talentTrackName == "helper" && _habboTalent.citizenshipEnabled)
         {
            return;
         }
         showWindow(_loc2_.talentTrackName,_loc2_.level,_loc2_.rewardPerks,_loc2_.rewardProducts);
      }
      
      public function showWindow(param1:String, param2:int, param3:Vector.<TalentTrackRewardPerk>, param4:Vector.<TalentTrackRewardProduct>) : void
      {
         closeWindow();
         UnknownVarFromTalentLevelUpController_String_1 = param1;
         _window = _habboTalent.getXmlWindow("level_up") as IWindowController_1;
         _window.center();
         _window.procedure = onWindowEvent;
         IStaticBitmapWrapperWindow(_window.findChildByName("level_decoration")).assetUri = "${image.library.url}talent/" + param1 + "_levelup_" + param2 + ".png";
         _window.findChildByName("level_up_message").caption = "${talent.track." + param1 + ".levelup.message}";
         _window.findChildByName("level_title").caption = "${talent.track." + param1 + ".level." + param2 + ".title}";
         _window.findChildByName("level_description").caption = "${talent.track." + param1 + ".level." + param2 + ".description}";
         var _loc8_:IItemListWindow = IItemListWindow(_window.findChildByName("reward_list"));
         var _loc6_:IWindowModel = _loc8_.removeListItem(_loc8_.getListItemByName("plus_template"));
         UnknownVarFromTalentLevelUpController_IWindowModel_1 = _loc8_.removeListItem(_loc8_.getListItemByName("reward_product_template"));
         UnknownVarFromTalentLevelUpController_IWindowModel_2 = _loc8_.removeListItem(_loc8_.getListItemByName("reward_vip_template"));
         UnknownVarFromTalentLevelUpController_IWindowModel_3 = _loc8_.removeListItem(_loc8_.getListItemByName("reward_perk_template"));
         var _loc7_:Boolean = false;
         for each(var _loc5_ in param3)
         {
            if(_loc7_)
            {
               _loc8_.addListItem(_loc6_.clone());
            }
            _loc8_.addListItem(createRewardPerk(_loc5_));
            _loc7_ = true;
         }
         for each(var _loc9_ in param4)
         {
            if(_loc7_)
            {
               _loc8_.addListItem(_loc6_.clone());
            }
            _loc8_.addListItem(createRewardProduct(_loc9_));
            _loc7_ = true;
         }
         if(_loc8_.numListItems < 1)
         {
            _window.findChildByName("level_rewards").visible = false;
            IItemListWindow(_window.findChildByName("level_up_layout")).arrangeListItems();
         }
      }
      
      private function createRewardPerk(param1:TalentTrackRewardPerk) : IWindowModel
      {
         var _loc2_:IWindowController_1 = UnknownVarFromTalentLevelUpController_IWindowModel_3.clone() as IWindowController_1;
         IBadgeImageWidget(IWidgetWindowController(_loc2_.findChildByName("perk_image")).widget).badgeId = param1.perkId;
         _loc2_.findChildByName("perk_name").caption = "${perk." + param1.perkId + ".name}";
         return _loc2_;
      }
      
      private function createRewardProduct(param1:TalentTrackRewardProduct) : IWindowModel
      {
         var _loc2_:IWindowModel = null;
         if(param1.vipDays == 0)
         {
            _loc2_ = UnknownVarFromTalentLevelUpController_IWindowModel_1.clone();
            IStaticBitmapWrapperWindow(_loc2_).assetUri = "${image.library.url}talent/reward_product_" + param1.productCode.toLowerCase().replace(" ","_") + ".png";
         }
         else
         {
            _loc2_ = UnknownVarFromTalentLevelUpController_IWindowModel_2.clone();
            IWindowController_1(_loc2_).findChildByName("vip_length").caption = _habboTalent.localizationManager.getLocalizationWithParams("catalog.vip.item.header.days","","num_days",param1.vipDays);
         }
         return _loc2_;
      }
      
      private function closeWindow() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         if(_window == null || Boolean(_window.disposed) || param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
            case "close_button":
               closeWindow();
               break;
            case "talent_button":
               closeWindow();
               _habboTalent.tracking.trackTalentTrackOpen(UnknownVarFromTalentLevelUpController_String_1,"levelup");
               _habboTalent.send(new GetTalentTrackMessageComposer(UnknownVarFromTalentLevelUpController_String_1));
         }
      }
   }
}

