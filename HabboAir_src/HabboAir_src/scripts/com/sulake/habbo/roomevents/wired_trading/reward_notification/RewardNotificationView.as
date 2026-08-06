package com.sulake.habbo.roomevents.wired_trading.reward_notification
{
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRule;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.nodes.TradeRequirementNode;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.transactions.WiredTransactionSuccessContents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.HtmlTextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.ButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.HtmlPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.PaddedContainerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.contracts.NodeOverviewPreset;
   import com.sulake.habbo.roomevents.wired_trading.AbstractUbuntuWiredUI;
   
   public class RewardNotificationView extends AbstractUbuntuWiredUI
   {
      private var UnknownVarFromRewardNotificationView_RewardNotificationController_1:RewardNotificationController;
      
      private var _contents:WiredTransactionSuccessContents;
      
      private var UnknownVarFromRewardNotificationView_TextPreset_1:TextPreset;
      
      private var UnknownVarFromRewardNotificationView_NodeOverviewPreset_1:NodeOverviewPreset;
      
      private var UnknownVarFromRewardNotificationView_HtmlPreset_1:HtmlPreset;
      
      private var UnknownVarFromRewardNotificationView_ButtonPreset_1:ButtonPreset;
      
      private var _viewIndex:int;
      
      public function RewardNotificationView(param1:RewardNotificationController, param2:PresetManager)
      {
         super(param1.roomEvents,param2);
         UnknownVarFromRewardNotificationView_RewardNotificationController_1 = param1;
         UnknownVarFromRewardNotificationView_TextPreset_1 = param2.createText("",TextParam.DEFAULT);
         UnknownVarFromRewardNotificationView_NodeOverviewPreset_1 = param2.createNodeOverviewPreset("${wiredrewards.title}",onClickNode);
         UnknownVarFromRewardNotificationView_HtmlPreset_1 = param2.createHtml(localization.getLocalization("wiredrewards.earnings"),HtmlTextParam.DEFAULT);
         IHTMLTextController(UnknownVarFromRewardNotificationView_HtmlPreset_1.window).initializeLinkStyle();
         UnknownVarFromRewardNotificationView_ButtonPreset_1 = param2.createButton("${wiredrewards.ok}",onClickButton);
         var _loc4_:SimpleListViewPreset = param2.createSimpleListView(true,[UnknownVarFromRewardNotificationView_TextPreset_1,UnknownVarFromRewardNotificationView_NodeOverviewPreset_1,UnknownVarFromRewardNotificationView_HtmlPreset_1,UnknownVarFromRewardNotificationView_ButtonPreset_1]);
         var _loc3_:PaddedContainerPreset = param2.createPaddedContainerPreset(_loc4_,7,7,7,7);
         framePreset = param2.createFramePreset([_loc3_],onCloseClicked);
         framePreset.resizeToWidth(276);
         framePreset.title = "${wiredrewards.title}";
      }
      
      private static function hasCreditNode(param1:TradeRequirementRule) : Boolean
      {
         for each(var _loc2_ in param1.nodes)
         {
            if(_loc2_.type == TradeRequirementNode.TYPE_COIN)
            {
               return true;
            }
         }
         return false;
      }
      
      private function onClickNode(param1:TradeRequirementNode) : void
      {
         UnknownVarFromRewardNotificationView_RewardNotificationController_1.context.createLinkEvent(param1.type == TradeRequirementNode.TYPE_COIN ? "habboUI/open/vault" : "inventory/open");
      }
      
      private function onClickButton() : void
      {
         onCloseClicked();
      }
      
      override protected function hideFrame() : void
      {
         super.hideFrame();
         UnknownVarFromRewardNotificationView_RewardNotificationController_1.closeRewardView(this);
      }
      
      override protected function get isBoundToParentRect() : Boolean
      {
         return true;
      }
      
      public function show(param1:WiredTransactionSuccessContents, param2:int, param3:int, param4:int) : void
      {
         _contents = param1;
         UnknownVarFromRewardNotificationView_TextPreset_1.text = param1.rewardText.length == 0 ? "${wiredrewards.desc_default}" : param1.rewardText;
         UnknownVarFromRewardNotificationView_NodeOverviewPreset_1.rule = param1.rewardContents;
         var _loc5_:Boolean = hasCreditNode(param1.rewardContents);
         UnknownVarFromRewardNotificationView_HtmlPreset_1.visible = _loc5_;
         showFrame();
         window.x += param2;
         window.y += param3;
         _viewIndex = param4;
      }
      
      public function get viewIndex() : int
      {
         return _viewIndex;
      }
      
      public function get contents() : WiredTransactionSuccessContents
      {
         return _contents;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(isShowing())
         {
            hide();
         }
         UnknownVarFromRewardNotificationView_ButtonPreset_1 = null;
         UnknownVarFromRewardNotificationView_NodeOverviewPreset_1 = null;
         UnknownVarFromRewardNotificationView_TextPreset_1 = null;
         UnknownVarFromRewardNotificationView_HtmlPreset_1 = null;
         UnknownVarFromRewardNotificationView_RewardNotificationController_1 = null;
         super.dispose();
      }
   }
}

