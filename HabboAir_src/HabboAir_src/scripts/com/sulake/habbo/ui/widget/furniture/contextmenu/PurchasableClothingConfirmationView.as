package com.sulake.habbo.ui.widget.furniture.contextmenu
{
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.communication.messages.outgoing.register.UpdateFigureDataMessageComposer;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.widgets.IAvatarImageWidget;
   import com.sulake.room.object.IRoomObject;
   
   public class PurchasableClothingConfirmationView implements IComponentInterfaceQueue
   {
      private static const PRODUCT_PAGE_UKNOWN:int = -1;
      
      private static const PRODUCT_PAGE_CLOTHING:int = 0;
      
      private static const UnknownConstFromPurchasableClothingConfirmationView_String_1:String = "header_button_close";
      
      private static const UnknownConstFromPurchasableClothingConfirmationView_String_2:String = "save_button";
      
      private static const UnknownConstFromPurchasableClothingConfirmationView_String_3:String = "cancel_text";
      
      private static const UnknownConstFromPurchasableClothingConfirmationView_String_4:String = "ok_button";
      
      private static const UnknownConstFromPurchasableClothingConfirmationView_String_5:String = "avatar_preview";
      
      private var _window:IWindowController_1;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1:FurnitureContextMenuWidget;
      
      private var _windowManager:IHabboWindowManagerComponent;
      
      private var _assets:IAssetLibraryCollection;
      
      private var UnknownVarFromPurchasableClothingConfirmationView_Int_1:int = -1;
      
      private var UnknownVarFromPurchasableClothingConfirmationView_IFurnitureData_1:IFurnitureData;
      
      private var _newFigureString:String;
      
      public function PurchasableClothingConfirmationView(param1:FurnitureContextMenuWidget)
      {
         super();
         UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1 = param1;
         _windowManager = param1.windowManager;
         _assets = UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.assets;
      }
      
      public function dispose() : void
      {
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function open(param1:int) : void
      {
         var _loc7_:Array = null;
         var _loc5_:int = UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.roomSession.roomId;
         var _loc6_:IRoomObject = UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.roomEngine.getRoomObject(_loc5_,param1,10);
         if(_loc6_ != null)
         {
            UnknownVarFromPurchasableClothingConfirmationView_IFurnitureData_1 = UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.getFurniData(_loc6_);
            UnknownVarFromPurchasableClothingConfirmationView_Int_1 = _loc6_.getId();
            var _loc3_:int = -1;
            var _loc2_:Vector.<int> = new Vector.<int>(0);
            switch(UnknownVarFromPurchasableClothingConfirmationView_IFurnitureData_1.category - 23)
            {
               case 0:
                  _loc3_ = 0;
                  _loc7_ = UnknownVarFromPurchasableClothingConfirmationView_IFurnitureData_1.customParams.split(",");
                  for each(var _loc4_ in _loc7_)
                  {
                     if(UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.container.avatarRenderManager.isValidFigureSetForGender(parseInt(_loc4_),UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.container.sessionDataManager.gender))
                     {
                        _loc2_.push(parseInt(_loc4_));
                     }
                  }
                  break;
               default:
                  Logger.log("[PurchasableClothingConfirmationView.open()] Unsupported furniture category: " + UnknownVarFromPurchasableClothingConfirmationView_IFurnitureData_1.category);
            }
            _newFigureString = UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.container.avatarRenderManager.getFigureStringWithFigureIds(UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.container.sessionDataManager.figure,UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.container.sessionDataManager.gender,_loc2_);
            if(UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.container.inventory.hasBoundFigureSetFurniture(UnknownVarFromPurchasableClothingConfirmationView_IFurnitureData_1.className))
            {
               UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.container.connection.send(new UpdateFigureDataMessageComposer(_newFigureString,UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.container.sessionDataManager.gender));
            }
            else
            {
               setWindowContent(_loc3_);
               _window.visible = true;
            }
            return;
         }
      }
      
      private function setWindowContent(param1:int) : void
      {
         var _loc3_:String = null;
         UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.localizations.registerParameter("useproduct.widget.title.bind_clothing","name",UnknownVarFromPurchasableClothingConfirmationView_IFurnitureData_1.localizedName);
         if(!_window)
         {
            _loc3_ = "use_product_widget_frame_plant_seed_xml";
            _window = _windowManager.buildFromXML(_assets.getAssetByName(_loc3_).content as XML) as IWindowController_1;
            addClickListener("header_button_close");
            _window.center();
         }
         _window.caption = "${useproduct.widget.title.bind_clothing}";
         UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.localizations.registerParameter("useproduct.widget.text.bind_clothing","productName",UnknownVarFromPurchasableClothingConfirmationView_IFurnitureData_1.localizedName);
         var _loc2_:IFrameController = _window as IFrameController;
         _loc2_.content.removeChildAt(0);
         var _loc4_:IWindowController_1 = createWindow(param1);
         _loc2_.content.addChild(_loc4_);
         switch(param1)
         {
            case 0:
               addClickListener("save_button");
               addClickListener("cancel_text");
               refreshAvatar();
               _window.invalidate();
               return;
            default:
               throw new Error("Invalid type for use product confirmation content apply: " + param1);
         }
      }
      
      private function createWindow(param1:int) : IWindowController_1
      {
         var _loc2_:ISoundAsset = null;
         var _loc3_:* = null;
         switch(param1)
         {
            case 0:
               _loc2_ = _assets.getAssetByName("use_product_controller_purchasable_clothing_xml");
               return _windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
            default:
               throw new Error("Invalid type for view content creation: " + param1);
         }
      }
      
      private function refreshAvatar() : void
      {
         var _loc1_:IWidgetWindowController = IWidgetWindowController(_window.findChildByName("avatar_preview"));
         var _loc2_:IAvatarImageWidget = IAvatarImageWidget(_loc1_.widget);
         _loc2_.figure = _newFigureString;
      }
      
      public function close() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function addClickListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",onMouseClick);
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_text":
            case "ok_button":
               close();
               break;
            case "save_button":
               UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.redeemPurchasableClothing(UnknownVarFromPurchasableClothingConfirmationView_Int_1,UnknownVarFromPurchasableClothingConfirmationView_IFurnitureData_1.className,_newFigureString,UnknownVarFromPurchasableClothingConfirmationView_FurnitureContextMenuWidget_1.handler.container.sessionDataManager.gender);
               close();
         }
      }
   }
}

