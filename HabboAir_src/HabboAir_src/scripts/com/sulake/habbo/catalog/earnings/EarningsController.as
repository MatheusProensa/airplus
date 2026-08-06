package com.sulake.habbo.catalog.earnings
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.vault.IncomeRewardClaimResponseMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.vault.IncomeRewardNotificationMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.vault.IncomeRewardStatusMessageEvent;
   import com.sulake.habbo.communication.messages.parser.vault.IncomeReward;
   import com.sulake.habbo.communication.messages.parser.vault.IncomeRewardClaimResponseMessageEventParser;
   import com.sulake.habbo.communication.messages.parser.vault.IncomeRewardStatusMessageEventParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.notifications.IHabboNotifications;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNotifications;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDSessionDataManager;
   
   public class EarningsController extends Component implements ILinkEventTracker, IEarningsController
   {
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _notifications:IHabboNotifications;
      
      private var _catalog:IHabboCatalog;
      
      private var _toolbar:IHabboToolbar;
      
      private var UnknownVarFromEarningsController_EarningsView_1:EarningsView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromEarningsController_Boolean_1:Boolean = true;
      
      private var _showingIndicator:Boolean = false;
      
      public function EarningsController(param1:IComponent_2, param2:uint = 0, param3:IAssetLibraryCollection = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         }),new ComponentDependency(new IIDHabboNotifications(),function(param1:IHabboNotifications):void
         {
            _notifications = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _messageEvents = new Vector.<IMessageEvent>(0);
         addMessageEvent(new IncomeRewardStatusMessageEvent(onIncomeRewardStatusMessageEvent));
         addMessageEvent(new IncomeRewardClaimResponseMessageEvent(onIncomeRewardClaimResponseMessageEvent));
         addMessageEvent(new IncomeRewardNotificationMessageEvent(onIncomeRewardNotificationMessageEvent));
         context.addLinkEventTracker(this);
      }
      
      private function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _messageEvents.push(_communicationManager.addHabboConnectionMessageEvent(param1));
      }
      
      private function onIncomeRewardStatusMessageEvent(param1:IncomeRewardStatusMessageEvent) : void
      {
         var _loc3_:IncomeRewardStatusMessageEventParser = param1.getParser();
         if(UnknownVarFromEarningsController_EarningsView_1 && !UnknownVarFromEarningsController_EarningsView_1.disposed)
         {
            UnknownVarFromEarningsController_EarningsView_1.onIncomeRewardDataReceived(_loc3_.data);
         }
         if(UnknownVarFromEarningsController_Boolean_1)
         {
            UnknownVarFromEarningsController_Boolean_1 = false;
            for each(var _loc2_ in _loc3_.data)
            {
               if(_loc2_.rewardType != 0 && _loc2_.amount > 0)
               {
                  _showingIndicator = true;
                  break;
               }
            }
            if(_showingIndicator)
            {
               _toolbar.refreshPurseAreaIndicators();
            }
         }
      }
      
      private function onIncomeRewardClaimResponseMessageEvent(param1:IncomeRewardClaimResponseMessageEvent) : void
      {
         var _loc2_:IncomeRewardClaimResponseMessageEventParser = null;
         if(UnknownVarFromEarningsController_EarningsView_1 && !UnknownVarFromEarningsController_EarningsView_1.disposed)
         {
            _loc2_ = param1.getParser();
            UnknownVarFromEarningsController_EarningsView_1.onIncomeRewardClaimResponse(_loc2_.rewardCategory,_loc2_.result);
         }
      }
      
      private function onIncomeRewardNotificationMessageEvent(param1:IncomeRewardNotificationMessageEvent) : void
      {
         _notifications.addItem("${notification.earning.new}","earning",null,"habboUI/open/vault");
         if(UnknownVarFromEarningsController_EarningsView_1)
         {
            _sessionDataManager.getIncomeRewardStatus();
         }
         if(!UnknownVarFromEarningsController_EarningsView_1 || UnknownVarFromEarningsController_EarningsView_1.disposed)
         {
            _showingIndicator = true;
            _toolbar.refreshPurseAreaIndicators();
         }
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function openCatalogue() : void
      {
         context.createLinkEvent("catalog/open");
      }
      
      public function get linkPattern() : String
      {
         return "habboUI/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length < 3)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            var _loc3_:* = _loc2_[2];
            if("vault" === _loc3_)
            {
               showEarnings();
            }
         }
      }
      
      public function withdrawVaultCredits() : void
      {
         _sessionDataManager.withdrawCreditVault();
      }
      
      public function claimReward(param1:int) : void
      {
         _sessionDataManager.claimReward(param1);
      }
      
      private function showEarnings() : void
      {
         if(_showingIndicator)
         {
            _showingIndicator = false;
            _toolbar.refreshPurseAreaIndicators();
         }
         _sessionDataManager.getIncomeRewardStatus();
         if(!UnknownVarFromEarningsController_EarningsView_1 || UnknownVarFromEarningsController_EarningsView_1.disposed)
         {
            UnknownVarFromEarningsController_EarningsView_1 = new EarningsView(this,_windowManager);
         }
      }
      
      public function get showingIndicator() : Boolean
      {
         return _showingIndicator;
      }
      
      public function removeView() : void
      {
         if(UnknownVarFromEarningsController_EarningsView_1)
         {
            UnknownVarFromEarningsController_EarningsView_1.dispose();
            UnknownVarFromEarningsController_EarningsView_1 = null;
         }
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      override public function dispose() : void
      {
         if(_messageEvents != null && _communicationManager != null)
         {
            for each(var _loc1_ in _messageEvents)
            {
               _communicationManager.removeHabboConnectionMessageEvent(_loc1_);
            }
         }
         removeView();
         _messageEvents = null;
         super.dispose();
      }
   }
}

