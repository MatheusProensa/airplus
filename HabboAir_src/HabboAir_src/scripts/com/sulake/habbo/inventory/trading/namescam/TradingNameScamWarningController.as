package com.sulake.habbo.inventory.trading.namescam
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.habbo.communication.IHabboCommunicationManager;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   
   public class TradingNameScamWarningController implements IComponentInterfaceQueue
   {
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var UnknownVarFromTradingNameScamWarningController_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var _localization:IHabboLocalizationManager;
      
      private var _communication:IHabboCommunicationManager;
      
      private var UnknownVarFromTradingNameScamWarningController_TradingNameScamWarningView_1:TradingNameScamWarningView;
      
      private var _disposed:Boolean;
      
      public function TradingNameScamWarningController(param1:IHabboWindowManagerComponent, param2:IAssetLibraryCollection, param3:IHabboLocalizationManager, param4:IHabboCommunicationManager)
      {
         super();
         _windowManager = param1;
         UnknownVarFromTradingNameScamWarningController_IAssetLibraryCollection_1 = param2;
         _localization = param3;
         _communication = param4;
      }
      
      public function show(param1:TradingNameScamWarningData) : void
      {
         if(_disposed || param1 == null)
         {
            return;
         }
         if(UnknownVarFromTradingNameScamWarningController_TradingNameScamWarningView_1 == null || UnknownVarFromTradingNameScamWarningController_TradingNameScamWarningView_1.disposed)
         {
            UnknownVarFromTradingNameScamWarningController_TradingNameScamWarningView_1 = new TradingNameScamWarningView(this,_windowManager,UnknownVarFromTradingNameScamWarningController_IAssetLibraryCollection_1,_localization);
         }
         UnknownVarFromTradingNameScamWarningController_TradingNameScamWarningView_1.show(param1);
      }
      
      public function hide() : void
      {
         if(UnknownVarFromTradingNameScamWarningController_TradingNameScamWarningView_1 != null && !UnknownVarFromTradingNameScamWarningController_TradingNameScamWarningView_1.disposed)
         {
            UnknownVarFromTradingNameScamWarningController_TradingNameScamWarningView_1.hide();
         }
      }
      
      public function openProfile(param1:int) : void
      {
         if(_disposed || param1 <= 0 || _communication == null || _communication.connection == null)
         {
            return;
         }
         _communication.connection.send(new GetExtendedProfileMessageComposer(param1));
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(UnknownVarFromTradingNameScamWarningController_TradingNameScamWarningView_1 != null)
         {
            UnknownVarFromTradingNameScamWarningController_TradingNameScamWarningView_1.dispose();
            UnknownVarFromTradingNameScamWarningController_TradingNameScamWarningView_1 = null;
         }
         _windowManager = null;
         UnknownVarFromTradingNameScamWarningController_IAssetLibraryCollection_1 = null;
         _localization = null;
         _communication = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

