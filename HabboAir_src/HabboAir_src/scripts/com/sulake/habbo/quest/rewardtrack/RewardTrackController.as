package com.sulake.habbo.quest.rewardtrack
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IComponent_2;
   import com.sulake.core.runtime.IProfiler_1;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.incoming.quest.rewardtrack.RewardTrackClaimResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.rewardtrack.RewardTrackPremiumPurchaseResultMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.rewardtrack.RewardTrackProgressMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.quest.rewardtrack.RewardTracksMessageEvent;
   import com.sulake.habbo.communication.messages.outgoing.quest.rewardtrack.ClaimRewardTrackPrizeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.quest.rewardtrack.PurchaseRewardTrackPremiumMessageComposer;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackClaimResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackData;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackPremiumPurchaseResultMessageParser;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTrackProgressMessageParser;
   import com.sulake.habbo.communication.messages.parser.quest.rewardtrack.RewardTracksMessageParser;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.quest.HabboQuestEngine;
   import com.sulake.habbo.quest.events.UnseenRewardTrackRewardsCountUpdateEvent;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrack;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackPrize;
   import com.sulake.habbo.quest.rewardtrack.data.RewardTrackTask;
   import com.sulake.habbo.quest.rewardtrack.view.RewardTrackView;
   import com.sulake.habbo.quest.rewardtrack.view.premium.RewardTrackPremiumPurchaseConfirmationView;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import flash.desktop.Clipboard;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class RewardTrackController extends Component implements ILinkEventTracker, IRewardTrackController, IComponentInterfaceQueue, IProfiler_1
   {
      public static const DESKTOP_WINDOW_LAYER:uint = 1;
      
      private static const FREE_CLAIM_NOTIFICATION_ICON:String = "reward_track_free_track";
      
      private static const PREMIUM_CLAIM_NOTIFICATION_ICON:String = "reward_track_premium_track";
      
      private var _communicationManager:IHabboCommunicationManager;
      
      private var _localizationManager:IHabboLocalizationManager;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _questEngine:HabboQuestEngine;
      
      private var _tracks:Vector.<RewardTrack>;
      
      private var UnknownVarFromRewardTrackController_Dictionary_1:Dictionary;
      
      private var UnknownVarFromRewardTrackController_RewardTrackView_1:RewardTrackView;
      
      private var UnknownVarFromRewardTrackController_RewardTrackPremiumPurchaseConfirmationView_1:RewardTrackPremiumPurchaseConfirmationView;
      
      private var _messageEvents:Vector.<IMessageEvent>;
      
      private var UnknownVarFromRewardTrackController_Int_1:int = -1;
      
      private var _disposed:Boolean;
      
      public function RewardTrackController(param1:HabboQuestEngine, param2:IComponent_2, param3:uint = 0, param4:IAssetLibraryCollection = null)
      {
         super(param2,param3,param4);
         _questEngine = param1;
         _tracks = new Vector.<RewardTrack>();
         UnknownVarFromRewardTrackController_Dictionary_1 = new Dictionary();
         _messageEvents = new Vector.<IMessageEvent>();
         _messageEvents.push(new RewardTracksMessageEvent(onRewardTracks));
         _messageEvents.push(new RewardTrackClaimResultMessageEvent(onRewardTrackClaimResult));
         _messageEvents.push(new RewardTrackProgressMessageEvent(onRewardTrackProgress));
         _messageEvents.push(new RewardTrackPremiumPurchaseResultMessageEvent(onRewardTrackPremiumPurchaseResult));
         for each(var _loc5_ in _messageEvents)
         {
            addMessageEvent(_loc5_);
         }
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:IHabboCommunicationManager):void
         {
            _communicationManager = param1;
         },true),new ComponentDependency(new IIDHabboWindowManager(),function(param1:IHabboWindowManagerComponent):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:IHabboLocalizationManager):void
         {
            _localizationManager = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         context.addLinkEventTracker(this);
      }
      
      public function get linkPattern() : String
      {
         return "reward_track/";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         if(_loc2_.length >= 3 && _loc2_[1] == "open")
         {
            openRewardTrack(_loc2_[2]);
         }
      }
      
      public function openRewardTrack(param1:String) : void
      {
         var _loc4_:RewardTrack = getTrackById(param1);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:Point = null;
         if(UnknownVarFromRewardTrackController_RewardTrackView_1 != null && !UnknownVarFromRewardTrackController_RewardTrackView_1.disposed)
         {
            _loc3_ = UnknownVarFromRewardTrackController_RewardTrackView_1.location;
            UnknownVarFromRewardTrackController_RewardTrackView_1.hide();
         }
         var _loc2_:RewardTrackView = UnknownVarFromRewardTrackController_Dictionary_1[param1] as RewardTrackView;
         if(_loc2_ == null || _loc2_.disposed)
         {
            _loc2_ = new RewardTrackView(this,_loc4_);
            UnknownVarFromRewardTrackController_Dictionary_1[param1] = _loc2_;
            _loc2_.initialize();
            _loc2_.center();
         }
         if(_loc3_ != null)
         {
            _loc2_.setLocation(_loc3_);
         }
         _loc2_.show();
         _loc2_.activate();
         UnknownVarFromRewardTrackController_RewardTrackView_1 = _loc2_;
      }
      
      public function claimPrize(param1:String, param2:String) : void
      {
         send(new ClaimRewardTrackPrizeMessageComposer(param1,param2));
      }
      
      public function purchasePremium(param1:String) : void
      {
         send(new PurchaseRewardTrackPremiumMessageComposer(param1));
      }
      
      public function get canCopyDebugIds() : Boolean
      {
         return _questEngine.sessionDataManager.hasSecurity(4) || _questEngine.sessionDataManager.hasSecurity(5);
      }
      
      public function copyTrackId(param1:String) : void
      {
         copyDebugId(param1,"${reward_track.debug.copy_track_id.success}");
      }
      
      public function copyTaskId(param1:String) : void
      {
         copyDebugId(param1,"${reward_track.debug.copy_task_id.success}");
      }
      
      public function openPremiumPurchaseConfirmation(param1:RewardTrack) : void
      {
         closePremiumPurchaseConfirmation();
         UnknownVarFromRewardTrackController_RewardTrackPremiumPurchaseConfirmationView_1 = new RewardTrackPremiumPurchaseConfirmationView(this,param1);
         UnknownVarFromRewardTrackController_RewardTrackPremiumPurchaseConfirmationView_1.show();
      }
      
      public function closePremiumPurchaseConfirmation() : void
      {
         if(UnknownVarFromRewardTrackController_RewardTrackPremiumPurchaseConfirmationView_1 != null)
         {
            UnknownVarFromRewardTrackController_RewardTrackPremiumPurchaseConfirmationView_1.dispose();
            UnknownVarFromRewardTrackController_RewardTrackPremiumPurchaseConfirmationView_1 = null;
         }
      }
      
      private function onRewardTracks(param1:RewardTracksMessageEvent) : void
      {
         var _loc2_:RewardTracksMessageParser = param1.getParser();
         var _loc3_:Boolean = UnknownVarFromRewardTrackController_RewardTrackView_1 != null && !UnknownVarFromRewardTrackController_RewardTrackView_1.disposed && UnknownVarFromRewardTrackController_RewardTrackView_1.isShowing();
         var _loc4_:* = _tracks.length > 0;
         if(_loc2_.reload || _loc2_.disabled || _loc4_)
         {
            disposeCachedViews();
            closePremiumPurchaseConfirmation();
         }
         _tracks = new Vector.<RewardTrack>();
         if(!_loc2_.disabled)
         {
            for each(var _loc5_ in _loc2_.tracks)
            {
               _tracks.push(new RewardTrack(_loc5_));
            }
         }
         if(_loc2_.reload && _loc3_)
         {
            _windowManager.alert(_localizationManager.getLocalization("reward_track.reload.title","reward_track.reload.title"),_localizationManager.getLocalization("reward_track.reload.desc","reward_track.reload.desc"),0,null);
         }
         broadcastClaimableRewardsCount();
      }
      
      private function onRewardTrackProgress(param1:RewardTrackProgressMessageEvent) : void
      {
         var _loc4_:RewardTrackProgressMessageParser = param1.getParser();
         var _loc5_:RewardTrack = getTrackById(_loc4_.trackId);
         if(_loc5_ == null)
         {
            return;
         }
         var _loc3_:RewardTrackTask = _loc5_.getTaskById(_loc4_.taskId);
         var _loc6_:Boolean = _loc3_ != null && _loc3_.hasProgress;
         var _loc2_:Boolean = _loc3_ != null && _loc3_.isComplete;
         _loc3_ = _loc5_.updateProgress(_loc4_.taskId,_loc4_.progressCount,_loc4_.points);
         updateProgressViews(_loc5_,_loc3_,_loc6_,_loc2_);
         broadcastClaimableRewardsCount(false);
      }
      
      private function onRewardTrackClaimResult(param1:RewardTrackClaimResultMessageEvent) : void
      {
         var _loc2_:RewardTrackClaimResultMessageParser = param1.getParser();
         if(_loc2_.resultCode != 0)
         {
            showNotification(localizeResult("reward_track.claim.notification.fail.",_loc2_.resultCode));
            return;
         }
         var _loc3_:RewardTrack = getTrackById(_loc2_.trackId);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:RewardTrackPrize = _loc3_.markPrizeClaimed(_loc2_.rewardId);
         updatePrizeClaimViews(_loc3_,_loc4_);
         broadcastClaimableRewardsCount();
         showClaimSuccessNotification(_loc4_);
      }
      
      private function onRewardTrackPremiumPurchaseResult(param1:RewardTrackPremiumPurchaseResultMessageEvent) : void
      {
         var _loc2_:RewardTrackPremiumPurchaseResultMessageParser = param1.getParser();
         if(_loc2_.resultCode != 0)
         {
            showNotification(localizeResult("reward_track.premium.notification.fail.",_loc2_.resultCode));
            if(UnknownVarFromRewardTrackController_RewardTrackPremiumPurchaseConfirmationView_1 != null && !UnknownVarFromRewardTrackController_RewardTrackPremiumPurchaseConfirmationView_1.disposed)
            {
               UnknownVarFromRewardTrackController_RewardTrackPremiumPurchaseConfirmationView_1.purchaseFailed();
            }
            return;
         }
         var _loc3_:RewardTrack = getTrackById(_loc2_.trackId);
         if(_loc3_ == null)
         {
            closePremiumPurchaseConfirmation();
            return;
         }
         _loc3_.markPremiumPurchased(_loc2_.points);
         updatePremiumPurchaseViews(_loc3_);
         broadcastClaimableRewardsCount();
         closePremiumPurchaseConfirmation();
         showNotification("${reward_track.premium.notification.success}");
      }
      
      private function broadcastClaimableRewardsCount(param1:Boolean = true) : void
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in _tracks)
         {
            for each(var _loc4_ in _loc3_.prizes)
            {
               if(_loc4_.isClaimable(_loc3_))
               {
                  _loc2_ += 1;
               }
            }
         }
         if(!param1 && _loc2_ == UnknownVarFromRewardTrackController_Int_1)
         {
            return;
         }
         UnknownVarFromRewardTrackController_Int_1 = _loc2_;
         _questEngine.events.dispatchEvent(new UnseenRewardTrackRewardsCountUpdateEvent(_loc2_));
      }
      
      private function localizeResult(param1:String, param2:int) : String
      {
         var _loc3_:String = param1 + param2;
         return _localizationManager.getLocalization(_loc3_,_loc3_);
      }
      
      private function showClaimSuccessNotification(param1:RewardTrackPrize) : void
      {
         showNotification("${reward_track.claim.notification.success}",param1 != null && param1.premium ? "reward_track_premium_track" : "reward_track_free_track");
      }
      
      private function showNotification(param1:String, param2:String = null) : void
      {
         var _loc3_:BitmapData = null;
         if(_questEngine.notifications != null)
         {
            if(param2 == null)
            {
               _questEngine.notifications.addItem(param1,"info");
            }
            else
            {
               _loc3_ = (_windowManager.assets.getAssetByName(param2).content as BitmapData).clone();
               _questEngine.notifications.addItemWithBitmap(param1,"info",_loc3_);
            }
         }
      }
      
      private function copyDebugId(param1:String, param2:String) : void
      {
         if(!canCopyDebugIds)
         {
            return;
         }
         Clipboard.generalClipboard.clear();
         Clipboard.generalClipboard.setData("air:text",param1);
         showNotification(param2);
      }
      
      private function updateProgressViews(param1:RewardTrack, param2:RewardTrackTask, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:RewardTrackView = getTrackView(param1);
         if(_loc5_ != null)
         {
            _loc5_.taskProgressUpdated(param2,param3,param4);
         }
      }
      
      private function updatePrizeClaimViews(param1:RewardTrack, param2:RewardTrackPrize) : void
      {
         var _loc3_:RewardTrackView = getTrackView(param1);
         if(_loc3_ != null)
         {
            _loc3_.prizeClaimed(param2);
         }
      }
      
      private function updatePremiumPurchaseViews(param1:RewardTrack) : void
      {
         var _loc2_:RewardTrackView = getTrackView(param1);
         if(_loc2_ != null)
         {
            _loc2_.premiumPurchased();
         }
      }
      
      private function getTrackView(param1:RewardTrack) : RewardTrackView
      {
         var _loc2_:RewardTrackView = UnknownVarFromRewardTrackController_Dictionary_1[param1.id] as RewardTrackView;
         if(_loc2_ != null && !_loc2_.disposed && _loc2_.track == param1)
         {
            return _loc2_;
         }
         return null;
      }
      
      private function disposeCachedViews() : void
      {
         for each(var _loc1_ in UnknownVarFromRewardTrackController_Dictionary_1)
         {
            if(_loc1_ != null && !_loc1_.disposed)
            {
               _loc1_.dispose();
            }
         }
         UnknownVarFromRewardTrackController_Dictionary_1 = new Dictionary();
         UnknownVarFromRewardTrackController_RewardTrackView_1 = null;
      }
      
      public function update(param1:uint) : void
      {
         for each(var _loc2_ in UnknownVarFromRewardTrackController_Dictionary_1)
         {
            if(_loc2_ != null && !_loc2_.disposed)
            {
               _loc2_.update(param1);
            }
         }
      }
      
      public function getTrackById(param1:String) : RewardTrack
      {
         for each(var _loc2_ in _tracks)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function isRewardTrackComplete(param1:String) : Boolean
      {
         var _loc2_:RewardTrack = getTrackById(param1);
         return _loc2_ != null && _loc2_.complete;
      }
      
      public function hasRewardTrack(param1:String) : Boolean
      {
         return getTrackById(param1) != null;
      }
      
      public function send(param1:IMessageComposer) : void
      {
         _communicationManager.connection.send(param1);
      }
      
      public function addMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.addHabboConnectionMessageEvent(param1);
      }
      
      public function removeMessageEvent(param1:IMessageEvent) : void
      {
         if(!_communicationManager)
         {
            return;
         }
         _communicationManager.removeHabboConnectionMessageEvent(param1);
      }
      
      override public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         context.removeLinkEventTracker(this);
         closePremiumPurchaseConfirmation();
         disposeCachedViews();
         for each(var _loc1_ in _messageEvents)
         {
            removeMessageEvent(_loc1_);
         }
         _messageEvents = null;
         _tracks = null;
         _communicationManager = null;
         _windowManager = null;
         _localizationManager = null;
         _questEngine = null;
         super.dispose();
      }
      
      override public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get tracks() : Vector.<RewardTrack>
      {
         return _tracks;
      }
      
      public function get localizationManager() : IHabboLocalizationManager
      {
         return _localizationManager;
      }
      
      public function get windowManager() : IHabboWindowManagerComponent
      {
         return _windowManager;
      }
      
      public function get questEngine() : HabboQuestEngine
      {
         return _questEngine;
      }
   }
}

