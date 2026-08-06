package com.sulake.habbo.session
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.messages.incoming.perk.PerkAllowancesMessageEvent;
   import com.sulake.habbo.communication.messages.parser.perk.Perk;
   import com.sulake.habbo.session.events.PerksUpdatedEvent;
   import flash.utils.Dictionary;
   
   public class PerkManager implements IComponentInterfaceQueue
   {
      private var _isReady:Boolean = false;
      
      private var _sessionDataManager:SessionDataManager;
      
      private var _perkAllowancesMessageEvent:IMessageEvent;
      
      private var UnknownVarFromPerkManager_Dictionary_1:Dictionary = new Dictionary();
      
      public function PerkManager(param1:SessionDataManager)
      {
         super();
         _sessionDataManager = param1;
         if(_sessionDataManager.communication)
         {
            _perkAllowancesMessageEvent = _sessionDataManager.communication.addHabboConnectionMessageEvent(new PerkAllowancesMessageEvent(onPerkAllowances));
         }
      }
      
      public function get disposed() : Boolean
      {
         return _sessionDataManager == null;
      }
      
      public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(UnknownVarFromPerkManager_Dictionary_1)
         {
            for(var _loc1_ in UnknownVarFromPerkManager_Dictionary_1)
            {
               delete UnknownVarFromPerkManager_Dictionary_1[_loc1_];
            }
            UnknownVarFromPerkManager_Dictionary_1 = null;
         }
         if(_sessionDataManager.communication)
         {
            _sessionDataManager.communication.removeHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
         }
         _perkAllowancesMessageEvent = null;
         _sessionDataManager = null;
      }
      
      public function get isReady() : Boolean
      {
         return _isReady;
      }
      
      public function isPerkAllowed(param1:String) : Boolean
      {
         return param1 in UnknownVarFromPerkManager_Dictionary_1 && UnknownVarFromPerkManager_Dictionary_1[param1].isAllowed;
      }
      
      public function getPerkErrorMessage(param1:String) : String
      {
         var _loc2_:Perk = UnknownVarFromPerkManager_Dictionary_1[param1];
         return _loc2_ != null ? _loc2_.errorMessage : "";
      }
      
      private function onPerkAllowances(param1:PerkAllowancesMessageEvent) : void
      {
         for each(var _loc2_ in param1.getParser().getPerks())
         {
            UnknownVarFromPerkManager_Dictionary_1[_loc2_.code] = _loc2_;
         }
         _isReady = true;
         _sessionDataManager.events.dispatchEvent(new PerksUpdatedEvent());
      }
   }
}

