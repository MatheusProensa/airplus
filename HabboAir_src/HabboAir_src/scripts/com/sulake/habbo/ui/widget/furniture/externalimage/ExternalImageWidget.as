package com.sulake.habbo.ui.widget.furniture.externalimage
{
   import adobe.serialization.json.JSONDecoder;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.assets.loaders.BitmapFileLoader;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IDisplayObjectWrapperController;
   import com.sulake.core.window.components.IHTMLTextController;
   import com.sulake.core.window.components.ILabelWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ISelectableWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.IWidgetWindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.utils.UnknownICoreWindowUtils2;
   import com.sulake.habbo.communication.messages.outgoing.users.GetExtendedProfileMessageComposer;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.IHabboInventory;
   import com.sulake.habbo.inventory.items.IFurnitureItem;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.ExternalImageWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import com.sulake.habbo.window.utils.AlertDialogCaption;
   import com.sulake.habbo.window.widgets.IIlluminaInputWidget;
   import com.sulake.room.object.IRoomObject;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   
   public class ExternalImageWidget extends RoomWidgetBase
   {
      private static const TYPE_PHOTO_POSTER:String = "photo_poster";
      
      private static const TYPE_SELFIE:String = "selfie";
      
      private static const TYPE_LEGACY:String = "legacy";
      
      private static const HORIZONTAL_ITEM_SPACING:int = 10;
      
      private static const VERTICAL_SPACE:int = 71;
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromExternalImageWidget_IBitmapWrapperController_1:IBitmapWrapperController;
      
      private var _moderationText:IHTMLTextController;
      
      private var _makeOwnButton:IWindowModel;
      
      private var UnknownVarFromExternalImageWidget_IWindowModel_1:IWindowModel;
      
      private var UnknownVarFromExternalImageWidget_IWindowController_1_1:IWindowController_1;
      
      private var _bgBorder:IWindowModel;
      
      private var _buttonContainer:IWindowController_1;
      
      private var _shareArea:IWindowController_1;
      
      private var _shareButton:IWindowModel;
      
      private var _senderNameButton:IRegionWindow;
      
      private var UnknownVarFromExternalImageWidget_ILabelWindow_1:ILabelWindow;
      
      private var UnknownVarFromExternalImageWidget_TextField_1:TextField;
      
      private var UnknownVarFromExternalImageWidget_ILabelWindow_2:ILabelWindow;
      
      private var UnknownVarFromExternalImageWidget_BitmapFileLoader_1:BitmapFileLoader;
      
      private var UnknownVarFromExternalImageWidget_Bitmap_1:Bitmap;
      
      private var _inventory:IHabboInventory;
      
      private var UnknownVarFromExternalImageWidget_Int_1:int;
      
      private var UnknownVarFromExternalImageWidget_String_1:String;
      
      private var _caption:String;
      
      private var UnknownVarFromExternalImageWidget_Int_2:int;
      
      private var UnknownVarFromExternalImageWidget_String_2:String;
      
      private var UnknownVarFromExternalImageWidget_IWindowController_1_2:IWindowController_1;
      
      private var UnknownVarFromExternalImageWidget_String_3:String;
      
      private var UnknownVarFromExternalImageWidget_IBitmapWrapperController_2:IBitmapWrapperController;
      
      private var _habboHelp:IHabboHelp;
      
      private var _roomEngine:IRoomEngine;
      
      private var reportWindow:IWindowController_1;
      
      private var UnknownVarFromExternalImageWidget_Int_3:int = 0;
      
      private var UnknownVarFromExternalImageWidget_Boolean_1:Boolean = false;
      
      private var UnknownVarFromExternalImageWidget_Component_1:Component;
      
      public function ExternalImageWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager, param5:IHabboInventory, param6:IHabboHelp, param7:IRoomEngine, param8:Component)
      {
         var _loc9_:IDisplayObjectWrapperController = null;
         super(param1,param2,param3,param4);
         _window = param2.buildFromXML(param3.getAssetByName("stories_image_widget_xml").content as XML) as IWindowController_1;
         ownHandler.widget = this;
         UnknownVarFromExternalImageWidget_IWindowModel_1 = _window.findChildByName("closebutton") as IWindowModel;
         UnknownVarFromExternalImageWidget_IBitmapWrapperController_1 = _window.findChildByName("imageLoader") as IBitmapWrapperController;
         _moderationText = _window.findChildByName("moderationText") as IHTMLTextController;
         _moderationText.addEventListener("WE_LINK",onClickModerationInfoLink);
         _shareArea = _window.findChildByName("shareArea") as IWindowController_1;
         UnknownVarFromExternalImageWidget_IWindowController_1_1 = _window.findChildByName("removeButtonContainer") as IWindowController_1;
         _makeOwnButton = _window.findChildByName("makeOwnButton") as IWindowModel;
         _shareButton = _window.findChildByName("shareButtonContainer") as IWindowModel;
         _bgBorder = _window.findChildByName("bgBorder") as IWindowModel;
         _senderNameButton = _window.findChildByName("senderNameButton") as IRegionWindow;
         UnknownVarFromExternalImageWidget_ILabelWindow_1 = _window.findChildByName("senderName") as ILabelWindow;
         UnknownVarFromExternalImageWidget_TextField_1 = new TextField();
         if(ownHandler.container.roomSession.roomControllerLevel == 5)
         {
            _loc9_ = _window.findChildByName("name_copy_wrapper") as IDisplayObjectWrapperController;
            UnknownVarFromExternalImageWidget_TextField_1.textColor = 10061943;
            UnknownVarFromExternalImageWidget_TextField_1.text = "";
            _loc9_.setDisplayObject(UnknownVarFromExternalImageWidget_TextField_1);
         }
         UnknownVarFromExternalImageWidget_ILabelWindow_2 = _window.findChildByName("creationDate") as ILabelWindow;
         _buttonContainer = _window.findChildByName("buttonContainer") as IWindowController_1;
         _inventory = param5;
         _habboHelp = param6;
         _roomEngine = param7;
         UnknownVarFromExternalImageWidget_IWindowController_1_2 = _window.findChildByName("reportButtonContainer") as IWindowController_1;
         _window.procedure = onWindowEvent;
         _window.center();
         _shareArea.visible = false;
         UnknownVarFromExternalImageWidget_Component_1 = param8;
         hide();
      }
      
      private function get ownHandler() : ExternalImageWidgetHandler
      {
         return _widgetHandler as ExternalImageWidgetHandler;
      }
      
      public function showWithRoomObject(param1:IRoomObject) : void
      {
         UnknownVarFromExternalImageWidget_Int_1 = param1.getId();
         UnknownVarFromExternalImageWidget_String_3 = param1.getType();
         UnknownVarFromExternalImageWidget_Boolean_1 = false;
         UnknownVarFromExternalImageWidget_IWindowController_1_1.visible = ownHandler.hasRightsToRemove();
         if(getType() == "photo_poster")
         {
            UnknownVarFromExternalImageWidget_IWindowController_1_2.visible = true;
         }
         else
         {
            UnknownVarFromExternalImageWidget_IWindowController_1_2.visible = ownHandler.isSelfieReportingEnabled();
         }
         show(param1.getModel().getString("furniture_data"));
         var _loc2_:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
         if(_loc2_.indexOf(param1) != -1)
         {
            UnknownVarFromExternalImageWidget_Int_3 = _loc2_.indexOf(param1);
         }
      }
      
      public function showWithFurniID(param1:int) : void
      {
         var _loc2_:IFurnitureItem = _inventory.getWallItemById(param1);
         if(_loc2_)
         {
            UnknownVarFromExternalImageWidget_Int_1 = param1;
            UnknownVarFromExternalImageWidget_String_3 = _roomEngine.getWallItemType(_loc2_.type);
            UnknownVarFromExternalImageWidget_Boolean_1 = true;
            UnknownVarFromExternalImageWidget_IWindowController_1_1.visible = false;
            UnknownVarFromExternalImageWidget_IWindowController_1_2.visible = false;
            show(_loc2_.stuffData.getLegacyString());
         }
      }
      
      private function show(param1:String) : void
      {
         if(ownHandler.storiesImageUrlBase == "disabled")
         {
            return;
         }
         clearImage();
         if(param1 != null)
         {
            readFurniJson(param1);
         }
      }
      
      private function showNext() : void
      {
         var _loc1_:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
         if(_loc1_.length > 0)
         {
            UnknownVarFromExternalImageWidget_Int_3++;
            if(UnknownVarFromExternalImageWidget_Int_3 > _loc1_.length - 1)
            {
               UnknownVarFromExternalImageWidget_Int_3 = 0;
            }
            showWithRoomObject(_loc1_[UnknownVarFromExternalImageWidget_Int_3]);
         }
      }
      
      private function showPrevious() : void
      {
         var _loc1_:Vector.<IRoomObject> = getWallItemsOfCurrentTypeInRoom();
         if(_loc1_.length > 0)
         {
            UnknownVarFromExternalImageWidget_Int_3--;
            if(UnknownVarFromExternalImageWidget_Int_3 < 0)
            {
               UnknownVarFromExternalImageWidget_Int_3 = _loc1_.length - 1;
            }
            showWithRoomObject(_loc1_[UnknownVarFromExternalImageWidget_Int_3]);
         }
      }
      
      private function getWallItemsOfCurrentTypeInRoom() : Vector.<IRoomObject>
      {
         var _loc2_:Vector.<IRoomObject> = new Vector.<IRoomObject>();
         var _loc3_:Array = _roomEngine.getObjectsByCategory(20);
         for each(var _loc1_ in _loc3_)
         {
            if(_loc1_.getType() == UnknownVarFromExternalImageWidget_String_3)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_;
      }
      
      private function clearImage() : void
      {
         UnknownVarFromExternalImageWidget_String_1 = null;
         _caption = "";
         var _loc1_:ITextWindow = _window.findChildByName("captionText") as ITextWindow;
         _loc1_.text = "";
         _senderNameButton.visible = false;
         UnknownVarFromExternalImageWidget_Int_2 = 0;
         UnknownVarFromExternalImageWidget_ILabelWindow_1.caption = "";
         UnknownVarFromExternalImageWidget_TextField_1.text = "";
         UnknownVarFromExternalImageWidget_ILabelWindow_2.caption = "";
         UnknownVarFromExternalImageWidget_String_2 = null;
         _moderationText.visible = false;
         drawImage(new Bitmap(new BitmapData(UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.width - 2,UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.height - 2,false,0)));
      }
      
      private function readFurniJson(param1:String) : void
      {
         try
         {
            UnknownVarFromExternalImageWidget_String_1 = new JSONDecoder(param1,false).getValue().id;
            if(UnknownVarFromExternalImageWidget_String_1)
            {
               loadExternalData();
               return;
            }
            loadPhoto(param1,getImageUrl(new JSONDecoder(param1,false).getValue()));
         }
         catch(error:Error)
         {
         }
      }
      
      private function getImageUrl(param1:Object) : String
      {
         var _loc3_:String = null;
         var _loc2_:String = getJsonValue(param1,"w","url");
         if(_loc2_.indexOf("http") != 0)
         {
            _loc3_ = "postcards/selfie/";
            if(getType() == "photo_poster")
            {
               _loc3_ = "";
            }
            if(_loc2_.indexOf(".png") == -1)
            {
               _loc2_ += ".png";
            }
            _loc2_ = ownHandler.storiesImageUrlBase + _loc3_ + _loc2_;
         }
         return _loc2_;
      }
      
      private function loadPhoto(param1:String, param2:String) : void
      {
         var _loc8_:Object = null;
         var _loc3_:IWindowModel = null;
         var _loc10_:String = null;
         var _loc7_:ITextWindow = null;
         try
         {
            _loc8_ = new JSONDecoder(param1,false).getValue();
         }
         catch(error:Error)
         {
            return;
         }
         if(!param2)
         {
            param2 = getImageUrl(_loc8_);
         }
         UnknownVarFromExternalImageWidget_BitmapFileLoader_1 = new BitmapFileLoader("image/png",new URLRequest(param2));
         UnknownVarFromExternalImageWidget_BitmapFileLoader_1.addEventListener("AssetLoaderEventComplete",onImageLoaded);
         var _loc4_:String = getJsonValue(_loc8_,"n","creator_name");
         var _loc5_:String = getJsonValue(_loc8_,"s","creator_id");
         var _loc11_:String = getJsonValue(_loc8_,"u","unique_id");
         var _loc6_:String = getJsonValue(_loc8_,"t","time");
         var _loc9_:Date = new Date(Number(_loc6_));
         if(_loc4_)
         {
            UnknownVarFromExternalImageWidget_ILabelWindow_1.caption = _loc4_;
            _senderNameButton.visible = true;
            UnknownVarFromExternalImageWidget_TextField_1.text = _loc4_;
            UnknownVarFromExternalImageWidget_Int_2 = int(_loc5_);
            UnknownVarFromExternalImageWidget_ILabelWindow_2.caption = _loc9_.date + "-" + (_loc9_.month + 1) + "-" + _loc9_.fullYear;
         }
         if(ownHandler.storiesImageShareUrl && ownHandler.storiesImageShareUrl.length > 4)
         {
            _loc3_ = _window.findChildByName("urlField") as IWindowModel;
            _loc10_ = ownHandler.storiesImageShareUrl.replace("%id%",_loc11_);
            _loc3_.caption = _loc10_;
            UnknownVarFromExternalImageWidget_String_2 = _loc10_;
         }
         _caption = getJsonValue(_loc8_,"m","caption");
         if(_caption)
         {
            _loc7_ = _window.findChildByName("captionText") as ITextWindow;
            _loc7_.text = _caption;
         }
      }
      
      private function getJsonValue(param1:Object, param2:String, param3:String = null) : String
      {
         var _loc4_:String = null;
         _loc4_ = param1[param2];
         if(!_loc4_ && param3)
         {
            _loc4_ = param1[param3];
         }
         return _loc4_;
      }
      
      private function onImageLoaded(param1:AssetLoaderEvent) : void
      {
         var _loc2_:Bitmap = null;
         if(UnknownVarFromExternalImageWidget_BitmapFileLoader_1)
         {
            _loc2_ = UnknownVarFromExternalImageWidget_BitmapFileLoader_1.content as Bitmap;
            if(_loc2_)
            {
               UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.width = _loc2_.width + 2;
               UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.height = _loc2_.height + 2;
               drawImage(_loc2_);
            }
         }
      }
      
      private function drawImage(param1:Bitmap) : void
      {
         UnknownVarFromExternalImageWidget_Bitmap_1 = param1;
         UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.bitmap = new BitmapData(UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.width,UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.height,true,0);
         _window.visible = true;
         var _loc3_:IWindowModel = _window.findChildByName("previousButton");
         var _loc2_:IWindowModel = _window.findChildByName("nextButton");
         _loc3_.x = 10;
         _bgBorder.y = _bgBorder.x = 0;
         UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.x = 10 * 2 + _loc3_.width;
         UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.y = 71;
         _bgBorder.height = _window.height = UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.height + 71 * 2;
         _bgBorder.width = _window.width = UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.width + 10 * 4 + _loc3_.width * 2;
         _senderNameButton.x = UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.right - _senderNameButton.width - 3;
         _senderNameButton.y = UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.bottom + 3;
         UnknownVarFromExternalImageWidget_ILabelWindow_2.x = UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.x + 3;
         UnknownVarFromExternalImageWidget_ILabelWindow_2.y = _senderNameButton.y = UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.bottom;
         _buttonContainer.y = 0;
         _buttonContainer.x = _bgBorder.right - _buttonContainer.width;
         _loc2_.x = UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.right + 10;
         if(UnknownVarFromExternalImageWidget_Boolean_1)
         {
            _loc2_.visible = _loc3_.visible = false;
         }
         else
         {
            _loc2_.visible = _loc3_.visible = getWallItemsOfCurrentTypeInRoom().length > 1;
         }
         var _loc4_:Matrix = new Matrix();
         var _loc5_:ColorTransform = new ColorTransform();
         _loc5_.color = 0;
         _loc4_.ty += 1;
         UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.tx += 1;
         _loc4_.ty -= 1;
         UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.ty += 2;
         UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.ty -= 1;
         _loc4_.tx += 1;
         UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.bitmap.draw(param1,_loc4_,_loc5_);
         _loc4_.tx -= 1;
         UnknownVarFromExternalImageWidget_IBitmapWrapperController_1.bitmap.draw(param1,_loc4_);
         _window.activate();
         updateWindowPosition();
      }
      
      private function loadExternalData() : void
      {
         var _loc2_:String = ownHandler.extraDataServiceUrl + UnknownVarFromExternalImageWidget_String_1;
         var _loc1_:URLLoader = new URLLoader(new URLRequest(_loc2_));
         _loc1_.addEventListener("httpStatus",onExternalDataHttpStatus);
         _loc1_.addEventListener("complete",onExternalDataLoaded);
         _loc1_.addEventListener("ioError",onExternalDataError);
      }
      
      private function onExternalDataHttpStatus(param1:HTTPStatusEvent) : void
      {
         if(param1.status == 403 && ownHandler.hasRightsToRemove())
         {
            _moderationText.visible = true;
         }
      }
      
      private function onExternalDataError(param1:Event) : void
      {
         if(!_moderationText.visible)
         {
            Logger.log("Extra data loading failed: " + param1.toString());
         }
      }
      
      private function onExternalDataLoaded(param1:Event) : void
      {
         var _loc2_:String = URLLoader(param1.target).data;
         if(_loc2_.length == 0)
         {
            return;
         }
         loadPhoto(_loc2_,null);
      }
      
      override public function dispose() : void
      {
         if(!_window)
         {
            return;
         }
         UnknownVarFromExternalImageWidget_IBitmapWrapperController_1 = null;
         UnknownVarFromExternalImageWidget_IWindowModel_1 = null;
         _bgBorder = null;
         _makeOwnButton = null;
         UnknownVarFromExternalImageWidget_IWindowController_1_1 = null;
         UnknownVarFromExternalImageWidget_BitmapFileLoader_1 = null;
         _inventory = null;
         _habboHelp = null;
         _roomEngine = null;
         UnknownVarFromExternalImageWidget_Int_2 = 0;
         _senderNameButton = null;
         UnknownVarFromExternalImageWidget_TextField_1 = null;
         _buttonContainer = null;
         _shareArea = null;
         _window.procedure = null;
         _window.dispose();
         UnknownVarFromExternalImageWidget_Component_1 = null;
         super.dispose();
         if(reportWindow)
         {
            reportWindow.destroy();
         }
      }
      
      public function hide() : void
      {
         _window.visible = false;
      }
      
      private function updateWindowPosition() : void
      {
         if(!UnknownVarFromExternalImageWidget_Bitmap_1)
         {
            _window.center();
            return;
         }
         var _loc5_:Stage = UnknownVarFromExternalImageWidget_Component_1.context.displayObjectContainer.stage;
         var _loc1_:Number = (_loc5_.stageWidth - 100) / UnknownVarFromExternalImageWidget_Bitmap_1.width;
         var _loc3_:Number = (_loc5_.stageHeight - 200) / UnknownVarFromExternalImageWidget_Bitmap_1.height;
         if(_loc1_ < 1)
         {
            _window.x = 50;
         }
         else
         {
            _window.x = (_loc5_.stageWidth - _window.width) * 0.5;
         }
         if(_loc3_ < 1)
         {
            _window.y = 50;
         }
         else
         {
            _window.y = (_loc5_.stageHeight - _window.height) * 0.5;
         }
         var _loc4_:IWindowModel = _window.findChildByName("previousButton");
         var _loc2_:IWindowModel = _window.findChildByName("nextButton");
         var _loc6_:int = UnknownVarFromExternalImageWidget_Component_1.context.displayObjectContainer.stage.stageHeight;
         if(_bgBorder.height > _loc6_)
         {
            _loc4_.y = _loc2_.y = _loc6_ / 2 - _loc4_.height / 2;
         }
         else
         {
            _loc4_.y = _loc2_.y = _bgBorder.height / 2 - _loc4_.height / 2;
         }
      }
      
      private function onWindowEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:UnknownICoreWindowUtils2 = null;
         var _loc4_:HabboToolbarEvent = null;
         var _loc5_:ITextFieldWindow = null;
         if(param2 == _window)
         {
            var _loc6_:* = param1.type;
            if("WE_PARENT_RESIZED" === _loc6_)
            {
               updateWindowPosition();
            }
         }
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "closebutton":
               hide();
               break;
            case "removebutton":
               _loc3_ = windowManager.confirm(_localizations.getLocalization("inventory.remove.external_image_wallitem_header"),_localizations.getLocalization("inventory.remove.external_image_wallitem_body"),0,onDeleteConfirm);
               _loc3_.setButtonCaption(16,new AlertDialogCaption(_localizations.getLocalization("inventory.remove.external_image_wallitem_delete"),"",true));
               break;
            case "makeOwnButton":
               if(getType() == "photo_poster")
               {
                  _loc4_ = new HabboToolbarEvent("HTE_ICON_CAMERA");
                  _loc4_.iconName = "imageWidgetMakeOwn";
                  ownHandler.container.toolbar.events.dispatchEvent(_loc4_);
                  hide();
               }
               else if(UnknownVarFromExternalImageWidget_Component_1.getInteger("spaweb",0) == 1)
               {
                  HabboWebTools.openPage("/stories/cards/selfie/edit");
               }
               else
               {
                  UnknownVarFromExternalImageWidget_Component_1.context.createLinkEvent("games/play/elisa_habbo_stories?ref=btn_selfie_myo");
               }
               break;
            case "shareButton":
               _shareArea.visible = true;
               HabboTracking.getInstance().trackEventLog("Stories","shareopened","stories.share.clicked",UnknownVarFromExternalImageWidget_String_3);
               break;
            case "twitterShare":
               navigateToURL(new URLRequest("http://www.twitter.com/share?url=" + UnknownVarFromExternalImageWidget_String_2),"_blank");
               HabboTracking.getInstance().trackEventLog("Stories","twitter","stories.share.clicked",UnknownVarFromExternalImageWidget_String_3);
               break;
            case "fbShare":
               navigateToURL(new URLRequest("https://www.facebook.com/sharer/sharer.php?u=" + UnknownVarFromExternalImageWidget_String_2),"_blank");
               HabboTracking.getInstance().trackEventLog("Stories","facebook","stories.share.clicked",UnknownVarFromExternalImageWidget_String_3);
               break;
            case "senderNameButton":
               ownHandler.sendMessage(new GetExtendedProfileMessageComposer(UnknownVarFromExternalImageWidget_Int_2));
               break;
            case "urlField":
               _loc5_ = _window.findChildByName("urlField") as ITextFieldWindow;
               _loc5_.setSelection(0,_loc5_.length);
               HabboTracking.getInstance().trackEventLog("Stories","fieldselected","stories.share.clicked",UnknownVarFromExternalImageWidget_String_3);
               break;
            case "reportButton":
               openReportImage();
               break;
            case "nextButton":
               showNext();
               break;
            case "previousButton":
               showPrevious();
         }
      }
      
      private function onClickModerationInfoLink(param1:WindowLinkEvent) : void
      {
         if(param1 != null && !StringUtil.isBlank(param1.link))
         {
            navigateToURL(new URLRequest(param1.link),"_blank");
         }
      }
      
      private function openReportImage() : void
      {
         _habboHelp.startPhotoReportingInNewCfhFlow(UnknownVarFromExternalImageWidget_Int_2,UnknownVarFromExternalImageWidget_ILabelWindow_1.caption,UnknownVarFromExternalImageWidget_String_1,UnknownVarFromExternalImageWidget_Int_1);
      }
      
      private function getType() : String
      {
         switch(UnknownVarFromExternalImageWidget_String_3)
         {
            case "external_image_wallitem_poster":
            case "external_image_wallitem_poster_small":
               break;
            case "external_image_wallitem":
               return "selfie";
            default:
               return "legacy";
         }
         return "photo_poster";
      }
      
      private function onReportWindowEvent(param1:WindowEvent, param2:IWindowModel) : void
      {
         var _loc3_:int = 0;
         var _loc9_:IWindowModel = null;
         var _loc8_:ISelectableWindow = null;
         var _loc6_:String = null;
         var _loc4_:IWindowModel = null;
         var _loc7_:IIlluminaInputWidget = null;
         var _loc5_:Boolean = false;
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "header_button_close":
               reportWindow.destroy();
               break;
            case "report_confirm":
               _loc3_ = 0;
               _loc9_ = reportWindow.findChildByName("reporting_reason");
               if(_loc9_ != null)
               {
                  _loc8_ = ISelectorWindow(_loc9_).getSelected();
                  if(_loc8_ != null)
                  {
                     _loc3_ = int(_loc8_.name);
                  }
               }
               _loc6_ = null;
               _loc4_ = reportWindow.findChildByName("input_widget");
               if(_loc4_ != null)
               {
                  _loc7_ = (_loc4_ as IWidgetWindowController).widget as IIlluminaInputWidget;
                  _loc6_ = _loc7_.message;
               }
               if(!UnknownVarFromExternalImageWidget_String_2)
               {
                  UnknownVarFromExternalImageWidget_String_2 = "url not available";
               }
               if(getType() == "photo_poster")
               {
                  _loc5_ = _habboHelp.reportPhoto(UnknownVarFromExternalImageWidget_String_1,_loc3_,_roomEngine.activeRoomId,UnknownVarFromExternalImageWidget_Int_2,UnknownVarFromExternalImageWidget_Int_1);
               }
               else
               {
                  _loc5_ = _habboHelp.reportSelfie(UnknownVarFromExternalImageWidget_String_2,_loc6_,_roomEngine.activeRoomId,UnknownVarFromExternalImageWidget_Int_2,UnknownVarFromExternalImageWidget_Int_1);
               }
               if(_loc5_)
               {
                  reportWindow.destroy();
               }
         }
      }
      
      private function onDeleteConfirm(param1:UnknownICoreWindowUtils2, param2:WindowEvent) : void
      {
         param1.dispose();
         if(param2.type == "WE_OK")
         {
            ownHandler.deleteCard(UnknownVarFromExternalImageWidget_Int_1);
         }
      }
      
      override public function release() : void
      {
         hide();
         super.release();
      }
   }
}

