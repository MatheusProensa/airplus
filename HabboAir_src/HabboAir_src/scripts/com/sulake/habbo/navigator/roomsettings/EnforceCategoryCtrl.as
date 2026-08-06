package com.sulake.habbo.navigator.roomsettings
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IDropBaseController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.habbo.communication.messages.incoming.navigator.FlatCategory;
   import com.sulake.habbo.communication.messages.outgoing.roomsettings.UpdateRoomCategoryAndTradeSettingsComposer;
   import com.sulake.habbo.navigator.IHabboNavigator_2;
   import com.sulake.habbo.window.utils.IModalDialog;
   
   public class EnforceCategoryCtrl
   {
      private var _navigator:IHabboNavigator_2;
      
      private var _window:IFrameController;
      
      private var UnknownVarFromEnforceCategoryCtrl_IModalDialog_1:IModalDialog;
      
      private var UnknownVarFromEnforceCategoryCtrl_Int_1:int = 0;
      
      private var UnknownVarFromEnforceCategoryCtrl_Int_2:int = 0;
      
      private var _visibleAndSelectableCategories:Array = [];
      
      public function EnforceCategoryCtrl(param1:IHabboNavigator_2)
      {
         super();
         _navigator = param1;
      }
      
      public function show(param1:int) : void
      {
         close();
         UnknownVarFromEnforceCategoryCtrl_IModalDialog_1 = _navigator.windowManager.buildModalDialogFromXML(_navigator.assets.getAssetByName("enforce_category_xml").content as XML);
         _window = UnknownVarFromEnforceCategoryCtrl_IModalDialog_1.rootWindow as IFrameController;
         _window.procedure = windowProcedure;
         _window.center();
         _window.findChildByName("header_button_close").visible = false;
         var _loc2_:IDropBaseController_1 = _window.findChildByName("trade_mode") as IDropBaseController_1;
         var _loc5_:Array = [];
         _loc5_.push("${navigator.roomsettings.trade_not_allowed}");
         _loc5_.push("${navigator.roomsettings.trade_not_with_Controller}");
         _loc5_.push("${navigator.roomsettings.trade_allowed}");
         _loc2_.populate(_loc5_);
         _loc2_.selection = 0;
         var _loc6_:IDropBaseController_1 = _window.findChildByName("category") as IDropBaseController_1;
         _visibleAndSelectableCategories = [];
         for each(var _loc7_ in _navigator.data.visibleCategories)
         {
            if(!_loc7_.automatic && (!_loc7_.staffOnly || _loc7_.staffOnly && _navigator.sessionData.hasSecurity(7)))
            {
               _visibleAndSelectableCategories.push(_loc7_);
            }
         }
         var _loc3_:Array = [];
         for each(var _loc4_ in _visibleAndSelectableCategories)
         {
            _loc3_.push(_loc4_.visibleName);
         }
         _loc6_.populate(_loc3_);
         _loc6_.selection = 0;
      }
      
      private function close() : void
      {
         if(UnknownVarFromEnforceCategoryCtrl_IModalDialog_1 && _window)
         {
            UnknownVarFromEnforceCategoryCtrl_IModalDialog_1.dispose();
            UnknownVarFromEnforceCategoryCtrl_IModalDialog_1 = null;
            _window = null;
         }
      }
      
      private function windowProcedure(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:int = 0;
         if(param1.type == "WME_CLICK")
         {
            var _loc4_:* = param2.name;
            if("ok" === _loc4_)
            {
               _loc3_ = int(FlatCategory(_visibleAndSelectableCategories[Math.max(0,UnknownVarFromEnforceCategoryCtrl_Int_1)]).nodeId);
               _navigator.communication.connection.send(new UpdateRoomCategoryAndTradeSettingsComposer(_navigator.data.currentRoomId,_loc3_,UnknownVarFromEnforceCategoryCtrl_Int_2));
               close();
            }
         }
         else if(param1.type == "WE_SELECTED")
         {
            switch(param2.name)
            {
               case "category":
                  UnknownVarFromEnforceCategoryCtrl_Int_1 = IDropBaseController_1(param2).selection;
                  break;
               case "trade_mode":
                  UnknownVarFromEnforceCategoryCtrl_Int_2 = IDropBaseController_1(param2).selection;
            }
         }
      }
   }
}

