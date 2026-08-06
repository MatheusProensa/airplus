package com.sulake.habbo.ui.widget.furniture.mannequin
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.components.IBitmapWrapperController;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.IAvatarFigureContainer;
   import com.sulake.habbo.avatar.IAvatarImage_2;
   import com.sulake.habbo.avatar.IAvatarRenderManager;
   import com.sulake.habbo.communication.messages.outgoing.room.engine.UseFurnitureMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetMannequinFigureComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.SetMannequinNameComposer;
   import com.sulake.habbo.localization.IHabboLocalizationManager;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.MannequinWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.IHabboWindowManagerComponent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MannequinWidget extends RoomWidgetBase
   {
      private static const CONTENT_CONTROLLER_MAIN:int = 0;
      
      private static const CONTENT_CONTROLLER_UPDATE:int = 1;
      
      private static const CONTENT_PEER_MAIN:int = 2;
      
      private static const CONTENT_NO_CLUB:int = 3;
      
      private static const CONTENT_WRONG_GENDER:int = 4;
      
      private static const UnknownConstFromMannequinWidget_String_1:String = "header_button_close";
      
      private static const UnknownConstFromMannequinWidget_String_2:String = "save_button";
      
      private static const UnknownConstFromMannequinWidget_String_3:String = "wear_button";
      
      private static const UnknownConstFromMannequinWidget_String_4:String = "configure_button";
      
      private static const UnknownConstFromMannequinWidget_String_5:String = "get_club_button";
      
      private static const UnknownConstFromMannequinWidget_String_6:String = "cancel_text";
      
      private static const UnknownConstFromMannequinWidget_String_7:String = "back_region";
      
      private static const UnknownConstFromMannequinWidget_String_8:String = "ok_button";
      
      private static const ELEM_OUTFIT_NAME_SET:String = "outfit_name_set";
      
      private static const UnknownConstFromMannequinWidget_String_9:String = "outfit_name_show";
      
      private static const NAME_STATE_HINT:int = 0;
      
      private static const NAME_STATE_WRITING:int = 1;
      
      private static const NAME_STATE_SAVED:int = 2;
      
      private static const NAME_TEXT_COLOR_SAVED:uint = 0;
      
      private static const NAME_TEXT_COLOR_WRITING:uint = 8956552;
      
      private static const NAME_TEXT_COLOR_HINT:uint = 7829367;
      
      private static const ICON_STYLE_CLUB:int = 13;
      
      private static const ICON_STYLE_VIP:int = 14;
      
      private static const MANNEQUIN_CLOTHING_PART_TYPES:Array = new Array("ca","cc","ch","lg","sh","wa");
      
      private static const MANNEQUIN_FIGURE:Array = ["hd",99999,[99998]];
      
      private var _window:IWindowController_1;
      
      private var UnknownVarFromMannequinWidget_Int_1:int;
      
      private var UnknownVarFromMannequinWidget_String_1:String;
      
      private var UnknownVarFromMannequinWidget_String_2:String;
      
      private var UnknownVarFromMannequinWidget_Int_2:int;
      
      private var _savedOutfitName:String;
      
      private var UnknownVarFromMannequinWidget_Int_3:int = -1;
      
      public function MannequinWidget(param1:IRoomWidgetHandler, param2:IHabboWindowManagerComponent, param3:IAssetLibraryCollection, param4:IHabboLocalizationManager)
      {
         super(param1,param2,param3,param4);
         this.handler.widget = this;
      }
      
      public function get handler() : MannequinWidgetHandler
      {
         return _widgetHandler as MannequinWidgetHandler;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         super.dispose();
      }
      
      public function open(param1:int, param2:String, param3:String, param4:String) : void
      {
         UnknownVarFromMannequinWidget_Int_1 = param1;
         UnknownVarFromMannequinWidget_String_1 = param2;
         UnknownVarFromMannequinWidget_String_2 = param3;
         _savedOutfitName = param4;
         var _loc10_:IRoomSession = (_widgetHandler as MannequinWidgetHandler).container.roomSession;
         var _loc6_:ISessionDataManager = (_widgetHandler as MannequinWidgetHandler).container.sessionDataManager;
         var _loc11_:Boolean = _loc10_.isRoomOwner || _loc10_.roomControllerLevel >= 1 || _loc6_.isAnyRoomController;
         var _loc8_:IAvatarRenderManager = (_widgetHandler as MannequinWidgetHandler).container.avatarRenderManager;
         var _loc9_:IAvatarFigureContainer = _loc8_.createFigureContainer(param2);
         UnknownVarFromMannequinWidget_Int_2 = _loc8_.resolveClubLevel(_loc9_,UnknownVarFromMannequinWidget_String_2,MANNEQUIN_CLOTHING_PART_TYPES);
         var _loc7_:int = resolveFirstWindowContent(_loc11_,_loc6_.gender,_loc6_.clubLevel,param3,UnknownVarFromMannequinWidget_Int_2);
         setWindowContent(_loc7_);
         var _loc5_:int = _savedOutfitName && _savedOutfitName != "" ? 2 : 0;
         setOutfitNameState(_loc5_);
         _window.visible = true;
      }
      
      private function resolveFirstWindowContent(param1:Boolean, param2:String, param3:int, param4:String, param5:int) : int
      {
         if(param1)
         {
            return 0;
         }
         if(param2.toLowerCase() != param4.toLowerCase())
         {
            return 2;
         }
         if(param3 < param5)
         {
            return 2;
         }
         return 2;
      }
      
      private function setWindowContent(param1:int) : void
      {
         var _loc7_:BitmapData = null;
         var _loc6_:IAvatarFigureContainer = null;
         var _loc3_:ISessionDataManager = (_widgetHandler as MannequinWidgetHandler).container.sessionDataManager;
         var _loc4_:String = _loc3_.figure;
         var _loc5_:IAvatarRenderManager = (_widgetHandler as MannequinWidgetHandler).container.avatarRenderManager;
         var _loc2_:int = _savedOutfitName && _savedOutfitName != "" ? 2 : 0;
         if(!_window)
         {
            _window = windowManager.buildFromXML(assets.getAssetByName("mannequin_widget_frame_xml").content as XML) as IWindowController_1;
            addClickListener("header_button_close");
            _window.center();
         }
         (_window as IFrameController).content.removeChildAt(0);
         var _loc8_:IWindowController_1 = createWindow(param1);
         (_window as IFrameController).content.addChild(_loc8_);
         switch(param1)
         {
            case 0:
               addClickListener("configure_button");
               addClickListener("wear_button");
               addTextFieldListener("outfit_name_set");
               addClickListener("outfit_name_set");
               _loc6_ = _loc5_.createFigureContainer(UnknownVarFromMannequinWidget_String_1);
               transformAsMannequinFigure(_loc6_);
               _loc7_ = createAvatarImage(_loc6_.getFigureString());
               updateClubLevelView(UnknownVarFromMannequinWidget_Int_2);
               setOutfitNameState(_loc2_);
               updateDecorations();
               break;
            case 1:
               addClickListener("save_button");
               addClickListener("back_region");
               _loc6_ = _loc5_.createFigureContainer(_loc4_);
               transformAsMannequinFigure(_loc6_);
               _loc7_ = createAvatarImage(_loc6_.getFigureString());
               updateClubLevelView(_loc5_.resolveClubLevel(_loc6_,_loc3_.gender,MANNEQUIN_CLOTHING_PART_TYPES));
               setOutfitNameState(_loc2_);
               break;
            case 2:
               addClickListener("wear_button");
               _loc6_ = applyMannequinOutfit(_loc4_,UnknownVarFromMannequinWidget_String_1);
               _loc7_ = createAvatarImage(_loc6_.getFigureString());
               updateClubLevelView(UnknownVarFromMannequinWidget_Int_2);
               setOutfitNameState(_loc2_);
               break;
            case 3:
               addClickListener("get_club_button");
               _loc6_ = applyMannequinOutfit(_loc4_,UnknownVarFromMannequinWidget_String_1);
               _loc7_ = createAvatarImage(_loc6_.getFigureString());
               updateClubLevelView(UnknownVarFromMannequinWidget_Int_2);
               break;
            case 4:
               addClickListener("ok_button");
               _loc6_ = _loc5_.createFigureContainer(UnknownVarFromMannequinWidget_String_1);
               transformAsMannequinFigure(_loc6_);
               _loc7_ = createAvatarImage(_loc6_.getFigureString());
               updateClubLevelView(UnknownVarFromMannequinWidget_Int_2);
               break;
            default:
               throw new Error("Invalid type for mannequin widget content apply: " + param1);
         }
         updatePreviewImage(_loc8_,_loc7_);
      }
      
      private function createWindow(param1:int) : IWindowController_1
      {
         var _loc3_:* = null;
         var _loc2_:ISoundAsset = null;
         switch(param1)
         {
            case 0:
               _loc2_ = _assets.getAssetByName("mannequin_controller_main_xml");
               break;
            case 1:
               _loc2_ = _assets.getAssetByName("mannequin_controller_save_xml");
               break;
            case 2:
               _loc2_ = _assets.getAssetByName("mannequin_peer_main_xml");
               break;
            case 3:
               _loc2_ = _assets.getAssetByName("mannequin_no_club_xml");
               break;
            case 4:
               _loc2_ = _assets.getAssetByName("mannequin_wrong_gender_xml");
               break;
            default:
               throw new Error("Invalid type for mannequin widget content creation: " + param1);
         }
         return (_widgetHandler as MannequinWidgetHandler).container.windowManager.buildFromXML(_loc2_.content as XML) as IWindowController_1;
      }
      
      private function transformAsMannequinFigure(param1:IAvatarFigureContainer) : void
      {
         for each(var _loc2_ in param1.getPartTypeIds())
         {
            if(MANNEQUIN_CLOTHING_PART_TYPES.indexOf(_loc2_) == -1)
            {
               param1.removePart(_loc2_);
            }
         }
         param1.updatePart(MANNEQUIN_FIGURE[0],MANNEQUIN_FIGURE[1],MANNEQUIN_FIGURE[2]);
      }
      
      private function createAvatarImage(param1:String) : BitmapData
      {
         var _loc3_:IAvatarRenderManager = (_widgetHandler as MannequinWidgetHandler).container.avatarRenderManager;
         var _loc4_:IAvatarImage_2 = _loc3_.createAvatarImage(param1,"h");
         var _loc2_:BitmapData = _loc4_.getCroppedImage("full");
         _loc4_.dispose();
         return _loc2_;
      }
      
      private function applyMannequinOutfit(param1:String, param2:String) : IAvatarFigureContainer
      {
         var _loc5_:* = null;
         var _loc4_:IAvatarRenderManager = (_widgetHandler as MannequinWidgetHandler).container.avatarRenderManager;
         var _loc3_:IAvatarFigureContainer = _loc4_.createFigureContainer(param1);
         var _loc6_:IAvatarFigureContainer = _loc4_.createFigureContainer(param2);
         for each(_loc5_ in MANNEQUIN_CLOTHING_PART_TYPES)
         {
            _loc3_.removePart(_loc5_);
         }
         for each(_loc5_ in _loc6_.getPartTypeIds())
         {
            _loc3_.updatePart(_loc5_,_loc6_.getPartSetId(_loc5_),_loc6_.getPartColorIds(_loc5_));
         }
         return _loc3_;
      }
      
      private function updateClubLevelView(param1:int) : void
      {
         var _loc2_:IIconWindow = _window.findChildByName("club_icon") as IIconWindow;
         if(!_loc2_)
         {
            return;
         }
         switch(param1)
         {
            case 0:
               _loc2_.visible = false;
               break;
            case 1:
               _loc2_.style = 13;
               _loc2_.visible = true;
               break;
            case 2:
               _loc2_.style = 14;
               _loc2_.visible = true;
         }
      }
      
      private function updatePreviewImage(param1:IWindowController_1, param2:BitmapData) : void
      {
         var _loc5_:BitmapData = null;
         if(!param1 || !param2)
         {
            return;
         }
         var _loc6_:IBitmapWrapperController = param1.findChildByName("preview_image") as IBitmapWrapperController;
         if(_loc6_.bitmap == null)
         {
            _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height);
         }
         var _loc3_:ISoundAsset = assets.getAssetByName("mannequin_preview_bg_png") as ISoundAsset;
         if(_loc3_)
         {
            _loc5_ = _loc3_.content as BitmapData;
            _loc6_.bitmap.copyPixels(_loc5_,_loc5_.rect,new Point(0,0));
         }
         var _loc4_:Point = new Point((_loc6_.width - param2.width) / 2,(_loc6_.height - param2.height) / 2);
         _loc6_.bitmap.copyPixels(param2,param2.rect,_loc4_,null,null,true);
      }
      
      private function updateDecorations() : void
      {
         var _loc1_:BitmapDataAsset = null;
         var _loc2_:IBitmapWrapperController = _window.findChildByName("write_deco") as IBitmapWrapperController;
         if(_loc2_)
         {
            _loc1_ = _assets.getAssetByName("small_pen") as BitmapDataAsset;
            _loc2_.bitmap = _loc1_.content as BitmapData;
            _loc2_.disposesBitmap = false;
         }
      }
      
      private function close() : void
      {
         _window.visible = false;
      }
      
      private function setOutfitNameState(param1:int) : void
      {
         UnknownVarFromMannequinWidget_Int_3 = param1;
         var _loc3_:ITextWindow = _window.findChildByName("outfit_name_set") as ITextWindow;
         if(_loc3_)
         {
            switch(param1)
            {
               case 0:
                  _loc3_.text = handler.container.localization.getLocalization("mannequin.widget.set_name_hint");
                  _loc3_.textColor = 7829367;
                  _loc3_.italic = true;
                  break;
               case 1:
                  _loc3_.textColor = 8956552;
                  _loc3_.italic = false;
                  break;
               case 2:
                  _loc3_.text = _savedOutfitName;
                  _loc3_.textColor = 0;
                  _loc3_.italic = false;
                  break;
               default:
                  _loc3_.text = handler.container.localization.getLocalization("mannequin.widget.set_name_hint");
                  _loc3_.textColor = 7829367;
            }
         }
         var _loc2_:ITextWindow = _window.findChildByName("outfit_name_show") as ITextWindow;
         if(_loc2_ && _savedOutfitName && _savedOutfitName != "")
         {
            _loc2_.text = "\'" + _savedOutfitName + "\'";
         }
      }
      
      private function clearNameField() : void
      {
         var _loc1_:ITextWindow = _window.findChildByName("outfit_name_set") as ITextWindow;
         if(_loc1_)
         {
            _loc1_.text = "";
         }
      }
      
      private function saveOutfit() : void
      {
         handler.container.connection.send(new SetMannequinFigureComposer(UnknownVarFromMannequinWidget_Int_1));
      }
      
      private function saveOutfitName() : void
      {
         var _loc1_:String = getNameFromView();
         handler.container.connection.send(new SetMannequinNameComposer(UnknownVarFromMannequinWidget_Int_1,_loc1_));
         _savedOutfitName = _loc1_;
         setOutfitNameState(2);
      }
      
      private function getNameFromView() : String
      {
         var _loc2_:String = (_window.findChildByName("outfit_name_set") as ITextWindow).text;
         var _loc1_:String = handler.container.localization.getLocalization("mannequin.widget.set_name_hint");
         return _loc2_ == _loc1_ ? "" : _loc2_;
      }
      
      private function addClickListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WME_CLICK",onMouseClick);
      }
      
      private function addTextFieldListener(param1:String) : void
      {
         _window.findChildByName(param1).addEventListener("WKE_KEY_UP",onKeyTyped);
      }
      
      private function onKeyTyped(param1:WindowKeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            saveOutfitName();
         }
         else if(UnknownVarFromMannequinWidget_Int_3 != 1)
         {
            setOutfitNameState(1);
         }
      }
      
      private function onMouseClick(param1:WindowMouseEvent) : void
      {
         var _loc2_:ISessionDataManager = (_widgetHandler as MannequinWidgetHandler).container.sessionDataManager;
         switch(param1.target.name)
         {
            case "header_button_close":
            case "cancel_text":
            case "ok_button":
               close();
               break;
            case "save_button":
               saveOutfit();
               close();
               break;
            case "wear_button":
               if(0 < 0)
               {
                  setWindowContent(3);
               }
               else if("0" != "0")
               {
                  setWindowContent(4);
               }
               else
               {
                  handler.container.connection.send(new UseFurnitureMessageComposer(UnknownVarFromMannequinWidget_Int_1));
                  close();
               }
               break;
            case "configure_button":
               saveOutfitName();
               setWindowContent(1);
               break;
            case "back_region":
               setWindowContent(0);
               break;
            case "get_club_button":
               (_widgetHandler as MannequinWidgetHandler).container.catalog.openClubCenter();
               close();
               break;
            case "outfit_name_set":
               if(UnknownVarFromMannequinWidget_Int_3 == 0)
               {
                  clearNameField();
                  setOutfitNameState(1);
               }
               else if(UnknownVarFromMannequinWidget_Int_3 == 2)
               {
                  setOutfitNameState(1);
               }
         }
      }
   }
}

