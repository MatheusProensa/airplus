package com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers.util
{
   import com.sulake.core.communication.util.Short;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.contracts.WiredContractContentsMessageParser;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.trade.requirements.rules.TradeRequirementRulesDefinition;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_trading.AbstractUbuntuWiredUI;
   import com.sulake.habbo.roomevents.wired_trading.contracts.WiredContractController;
   import com.sulake.habbo.roomevents.wired_trading.contracts.subcontrollers.IAddEditContractElement;
   
   public class AbstractContract extends AbstractUbuntuWiredUI implements IAddEditContractElement
   {
      private var _contractId:int = -1;
      
      private var _parentController:WiredContractController;
      
      public function AbstractContract(param1:WiredContractController, param2:PresetManager)
      {
         super(param1.roomEvents,param2);
         _parentController = param1;
      }
      
      override protected function get isBoundToParentRect() : Boolean
      {
         return true;
      }
      
      public function get contractId() : int
      {
         return _contractId;
      }
      
      public function set contractId(param1:int) : void
      {
         _contractId = param1;
      }
      
      protected function get parentController() : WiredContractController
      {
         return _parentController;
      }
      
      override public function onSaveClicked() : void
      {
         parentController.saveContract(this);
      }
      
      override protected function hideFrame() : void
      {
         if(isShowing())
         {
            parentController.cacheWindowLocation(window);
            parentController.addEditContractElement.hide();
         }
         super.hideFrame();
      }
      
      public function show(param1:WiredContractContentsMessageParser) : void
      {
         contractId = param1.contractId;
         footerPreset.saveButtonDisabled = !roomEvents.wiredMenu.hasWritePermission;
      }
      
      protected function createNewDefinitionFromUI() : TradeRequirementRulesDefinition
      {
         return null;
      }
      
      public function addContentsToComposer(param1:Array) : void
      {
         param1.push(contractId);
         param1.push(new Short(contractType()));
         createNewDefinitionFromUI().addToComposer(param1);
      }
      
      public function contractType() : int
      {
         return 0;
      }
      
      public function validate() : String
      {
         return null;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         _parentController = null;
         super.dispose();
      }
   }
}

