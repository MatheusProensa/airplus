package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.IWindowController_1;
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.components.IFrameController;
   import com.sulake.habbo.avatar.common.AvatarEditorGridColorItem;
   import com.sulake.habbo.avatar.common.AvatarEditorGridPartItem;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.ICategoryBaseModel_1;
   import com.sulake.habbo.avatar.common.ISideContentModel;
   import com.sulake.habbo.avatar.effects.EffectsModel;
   import com.sulake.habbo.avatar.events.AvatarUpdateEvent;
   import com.sulake.habbo.avatar.figuredata.FigureData;
   import com.sulake.habbo.avatar.generic.BodyModel;
   import com.sulake.habbo.avatar.head.HeadModel;
   import com.sulake.habbo.avatar.hotlooks.HotLooksModel;
   import com.sulake.habbo.avatar.legs.LegsModel;
   import com.sulake.habbo.avatar.misc.MiscModel;
   import com.sulake.habbo.avatar.nft.NftAvatarsModel;
   import com.sulake.habbo.avatar.structure.IFigureSetData;
   import com.sulake.habbo.avatar.structure.figure.IFigurePartSet;
   import com.sulake.habbo.avatar.structure.figure.IPalette;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import com.sulake.habbo.avatar.structure.figure.ISetType;
   import com.sulake.habbo.avatar.torso.TorsoModel;
   import com.sulake.habbo.avatar.wardrobe.NftOutfit;
   import com.sulake.habbo.avatar.wardrobe.WardrobeModel;
   import com.sulake.habbo.communication.messages.outgoing.nft.GetSelectedNftWardrobeOutfitMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.nft.SaveUserNftWardrobeMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.register.UpdateFigureDataMessageComposer;
   import com.sulake.habbo.communication.messages.parser.nft.UserNftWardrobeSelectionMessageEvent;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class HabboAvatarEditor
   {
      public static const DEFAULT_MALE_FIGURE:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
      
      public static const DEFAULT_FEMALE_FIGURE:String = "hr-515-33.hd-600-1.ch-635-70.lg-716-66-62.sh-735-68";
      
      private static const MAX_COLOR_LAYERS:int = 2;
      
      private var _instanceId:uint;
      
      private var _manager:HabboAvatarEditorManager;
      
      private var UnknownVarFromHabboAvatarEditor_IFigureSetData_1:IFigureSetData;
      
      private var _view:AvatarEditorView;
      
      private var UnknownVarFromHabboAvatarEditor_Boolean_1:Boolean = false;
      
      private var _categories:Map;
      
      private var UnknownVarFromHabboAvatarEditor_Map_1:Map;
      
      private var _figures:Dictionary;
      
      private var _gender:String = "M";
      
      private var _figureString:String;
      
      private var UnknownVarFromHabboAvatarEditor_UnknownIHabboAvatar2_1:UnknownIHabboAvatar2 = null;
      
      private var _isSideContentEnabled:Boolean = false;
      
      private var UnknownVarFromHabboAvatarEditor_Boolean_2:Boolean = false;
      
      private var _setNftOutfit:NftOutfit = null;
      
      private var UnknownVarFromHabboAvatarEditor_Int_1:int;
      
      private var UnknownVarFromHabboAvatarEditor_Boolean_3:Boolean = false;
      
      private var UnknownVarFromHabboAvatarEditor_UserNftWardrobeSelectionMessageEvent_1:UserNftWardrobeSelectionMessageEvent;
      
      private var UnknownVarFromHabboAvatarEditor_String_1:String;
      
      private var UnknownVarFromHabboAvatarEditor_String_2:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
      
      private var UnknownVarFromHabboAvatarEditor_String_3:String = "M";
      
      private var UnknownVarFromHabboAvatarEditor_String_4:String = "hr-100.hd-180-7.ch-215-66.lg-270-79.sh-305-62.ha-1002-70.wa-2007";
      
      private var UnknownVarFromHabboAvatarEditor_String_5:String = "M";
      
      public function HabboAvatarEditor(param1:uint, param2:HabboAvatarEditorManager, param3:Boolean = false)
      {
         super();
         _instanceId = param1;
         _manager = param2;
         UnknownVarFromHabboAvatarEditor_IFigureSetData_1 = _manager.avatarRenderManager.getFigureData();
         UnknownVarFromHabboAvatarEditor_Boolean_3 = param3;
      }
      
      public function dispose() : void
      {
         if(UnknownVarFromHabboAvatarEditor_UserNftWardrobeSelectionMessageEvent_1 != null)
         {
            _manager.communication.removeHabboConnectionMessageEvent(UnknownVarFromHabboAvatarEditor_UserNftWardrobeSelectionMessageEvent_1);
            UnknownVarFromHabboAvatarEditor_UserNftWardrobeSelectionMessageEvent_1 = null;
         }
         if(_categories != null)
         {
            for each(var _loc2_ in _categories)
            {
               _loc2_.dispose();
               _loc2_ = null;
            }
            _categories = null;
         }
         if(UnknownVarFromHabboAvatarEditor_Map_1 != null)
         {
            for each(var _loc1_ in UnknownVarFromHabboAvatarEditor_Map_1)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            UnknownVarFromHabboAvatarEditor_Map_1 = null;
         }
         if(_view != null)
         {
            _view.dispose();
            _view = null;
         }
         UnknownVarFromHabboAvatarEditor_IFigureSetData_1 = null;
         _figures = null;
         UnknownVarFromHabboAvatarEditor_UnknownIHabboAvatar2_1 = null;
      }
      
      private function init(param1:Array = null) : void
      {
         if(UnknownVarFromHabboAvatarEditor_Boolean_1)
         {
            return;
         }
         if(_manager.communication)
         {
            if(this.isDevelopmentEditor() == false)
            {
               UnknownVarFromHabboAvatarEditor_UserNftWardrobeSelectionMessageEvent_1 = new UserNftWardrobeSelectionMessageEvent(onUserNftWardrobeMessage);
               _manager.communication.addHabboConnectionMessageEvent(UnknownVarFromHabboAvatarEditor_UserNftWardrobeSelectionMessageEvent_1);
               sendGetSelectedNftWardrobeOutfitMessage();
            }
         }
         _categories = new Map();
         UnknownVarFromHabboAvatarEditor_Map_1 = new Map();
         UnknownVarFromHabboAvatarEditor_Map_1.add("wardrobe",new WardrobeModel(this));
         _view = new AvatarEditorView(this,param1);
         _figures = new Dictionary();
         _figures["M"] = new FigureData(this);
         _figures["F"] = new FigureData(this);
         var _loc3_:FigureData = _figures["M"];
         var _loc2_:FigureData = _figures["F"];
         _loc3_.loadAvatarData("hr-893-45.hd-180-10.ch-235-71.lg-3088-73-73.fa-3276-72","M");
         _loc2_.loadAvatarData("hr-515-45.hd-600-10.ch-665-71.lg-3216-73.fa-3276-72","F");
         _categories.add("generic",new BodyModel(this));
         _categories.add("head",new HeadModel(this));
         _categories.add("torso",new TorsoModel(this));
         _categories.add("legs",new LegsModel(this));
         _categories.add("misc",new MiscModel(this));
         if(this.isDevelopmentEditor() == false)
         {
            if(param1 == null || param1.indexOf("hotlooks") > -1)
            {
               _categories.add("hotlooks",new HotLooksModel(this));
            }
            _categories.add("effects",new EffectsModel(this));
            _categories.add("nfts",new NftAvatarsModel(this));
         }
         UnknownVarFromHabboAvatarEditor_Boolean_1 = true;
      }
      
      private function sendGetSelectedNftWardrobeOutfitMessage() : void
      {
         if(_manager.communication)
         {
            _manager.communication.connection.send(new GetSelectedNftWardrobeOutfitMessageComposer());
         }
      }
      
      private function onUserNftWardrobeMessage(param1:UserNftWardrobeSelectionMessageEvent) : void
      {
         UnknownVarFromHabboAvatarEditor_String_1 = param1.getParser().currentTokenId;
         UnknownVarFromHabboAvatarEditor_String_2 = param1.getParser().fallbackFigureString;
         UnknownVarFromHabboAvatarEditor_String_3 = param1.getParser().fallbackFigureGender;
         if(hasNftOutfit() && _view.currentViewId != "nfts")
         {
            loadFallbackFigure();
         }
      }
      
      public function loadAvatarInEditor(param1:String, param2:String, param3:int = 0) : void
      {
         switch(param2)
         {
            case "M":
            case "m":
            case "M":
               param2 = "M";
               break;
            case "F":
            case "f":
            case "F":
               param2 = "F";
               break;
            default:
               param2 = "M";
         }
         this.clubMemberLevel = param3;
         var _loc4_:Boolean = false;
         var _loc5_:FigureData = _figures[param2];
         if(_loc5_ == null)
         {
            return;
         }
         _loc5_.loadAvatarData(param1,param2);
         if(param2 != this.gender)
         {
            this.gender = param2;
            _loc4_ = true;
         }
         if(_figureString != param1)
         {
            _figureString = param1;
            _loc4_ = true;
         }
         if(_categories && _loc4_)
         {
            for each(var _loc6_ in _categories)
            {
               _loc6_.reset();
            }
         }
         if(_view != null)
         {
            _view.update();
         }
      }
      
      public function getFigureSetType(param1:String) : ISetType
      {
         if(UnknownVarFromHabboAvatarEditor_IFigureSetData_1 == null)
         {
            return null;
         }
         return UnknownVarFromHabboAvatarEditor_IFigureSetData_1.getSetType(param1);
      }
      
      public function getPalette(param1:int) : IPalette
      {
         if(UnknownVarFromHabboAvatarEditor_IFigureSetData_1 == null)
         {
            return null;
         }
         return UnknownVarFromHabboAvatarEditor_IFigureSetData_1.getPalette(param1);
      }
      
      public function openWindow(param1:UnknownIHabboAvatar2, param2:Array = null, param3:Boolean = false, param4:String = null, param5:String = "generic") : IFrameController
      {
         UnknownVarFromHabboAvatarEditor_UnknownIHabboAvatar2_1 = param1;
         _isSideContentEnabled = param3;
         init(param2);
         selectDefaultCategory(param2,param5);
         return _view.getFrame(param2,param4);
      }
      
      public function embedToContext(param1:IWindowController_1 = null, param2:UnknownIHabboAvatar2 = null, param3:Array = null, param4:Boolean = false) : Boolean
      {
         UnknownVarFromHabboAvatarEditor_UnknownIHabboAvatar2_1 = param2;
         _isSideContentEnabled = param4;
         init(param3);
         _view.embedToContext(param1,param3);
         selectDefaultCategory(param3);
         return true;
      }
      
      private function selectDefaultCategory(param1:Array, param2:String = "generic") : void
      {
         var _loc3_:Boolean = param1 != null && param1.length > 0;
         if(param2 != null && (!_loc3_ || param1.indexOf(param2) >= 0))
         {
            toggleAvatarEditorPage(param2);
         }
         else if(_loc3_)
         {
            toggleAvatarEditorPage(param1[0]);
         }
         else
         {
            toggleAvatarEditorPage("generic");
         }
      }
      
      public function get instanceId() : uint
      {
         return _instanceId;
      }
      
      public function hide() : void
      {
         _view.hide();
      }
      
      public function getCategoryWindowContainer(param1:String) : IWindowModel
      {
         var _loc2_:ICategoryBaseModel_1 = _categories.getValue(param1) as ICategoryBaseModel_1;
         if(_loc2_ != null)
         {
            return _loc2_.getWindowContainer();
         }
         return null;
      }
      
      public function activateCategory(param1:String) : void
      {
         var _loc2_:ICategoryBaseModel_1 = _categories.getValue(param1) as ICategoryBaseModel_1;
         if(_loc2_)
         {
            _loc2_.switchCategory();
         }
      }
      
      public function getSideContentWindowContainer(param1:String) : IWindowController_1
      {
         var _loc2_:ISideContentModel = UnknownVarFromHabboAvatarEditor_Map_1.getValue(param1) as ISideContentModel;
         if(_loc2_ != null)
         {
            return _loc2_.getWindowContainer();
         }
         return null;
      }
      
      public function toggleAvatarEditorPage(param1:String) : void
      {
         if(_view)
         {
            _view.toggleCategoryView(param1,false);
         }
      }
      
      public function useClubClothing() : void
      {
         if(_categories == null)
         {
            return;
         }
         update();
      }
      
      public function disableClubClothing() : void
      {
         if(_categories == null)
         {
            return;
         }
         update();
      }
      
      public function get figureData() : FigureData
      {
         return _figures[_gender];
      }
      
      public function saveCurrentSelection() : void
      {
         if(_manager.windowManager.LilithCustomsInstance.OnHabboAvatarEditorSaveCurrentSelection(this) == false)
         {
            return;
         }
         var _loc1_:String = figureData.getFigureString();
         var _loc2_:String = figureData.gender;
         if(UnknownVarFromHabboAvatarEditor_UnknownIHabboAvatar2_1 != null)
         {
            UnknownVarFromHabboAvatarEditor_UnknownIHabboAvatar2_1.saveFigure(_loc1_,_loc2_);
         }
         else
         {
            if(_manager.communication)
            {
               if(_setNftOutfit != null)
               {
                  _manager.communication.connection.send(new SaveUserNftWardrobeMessageComposer(_setNftOutfit.id));
                  sendGetSelectedNftWardrobeOutfitMessage();
                  _setNftOutfit = null;
               }
               else
               {
                  _manager.communication.connection.send(new UpdateFigureDataMessageComposer(_loc1_,_loc2_));
               }
            }
            if(hasNftOutfit())
            {
               UnknownVarFromHabboAvatarEditor_String_1 = null;
            }
            _manager.events.dispatchEvent(new AvatarUpdateEvent(_loc1_));
            if(UnknownVarFromHabboAvatarEditor_Boolean_2)
            {
               if(figureData.avatarEffectType != -1)
               {
                  _manager.inventory.setEffectSelected(figureData.avatarEffectType);
               }
               else
               {
                  _manager.inventory.deselectAllEffects(true);
               }
            }
            UnknownVarFromHabboAvatarEditor_Boolean_2 = false;
         }
      }
      
      public function generateDataContent(param1:ICategoryBaseModel_1, param2:String) : CategoryData
      {
         var _loc21_:int = 0;
         var _loc14_:IFigurePartSet = null;
         var _loc9_:AvatarEditorGridPartItem = null;
         var _loc22_:ISetType = null;
         var _loc10_:IPalette = null;
         var _loc13_:Array = null;
         var _loc12_:Array = null;
         var _loc19_:Boolean = false;
         var _loc11_:int = 0;
         var _loc15_:* = false;
         var _loc18_:AvatarEditorGridColorItem = null;
         var _loc26_:int = 0;
         var _loc30_:Array = null;
         var _loc17_:int = 0;
         var _loc32_:* = false;
         var _loc33_:BitmapDataAsset = null;
         var _loc25_:BitmapData = null;
         var _loc24_:IWindowController_1 = null;
         var _loc29_:* = false;
         var _loc31_:Map = null;
         var _loc16_:int = 0;
         var _loc27_:int = 0;
         var _loc6_:Boolean = false;
         var _loc34_:* = false;
         var _loc3_:Boolean = false;
         var _loc20_:BitmapDataAsset = null;
         var _loc23_:BitmapData = null;
         var _loc7_:IWindowController_1 = null;
         var _loc5_:Array = null;
         if(!param1)
         {
            return null;
         }
         if(!param2)
         {
            return null;
         }
         var _loc4_:Array = [];
         var _loc8_:Array = [];
         _loc21_ = 0;
         while(_loc21_ < 2)
         {
            _loc8_.push([]);
            _loc21_++;
         }
         _loc22_ = getFigureSetType(param2);
         if(!_loc22_)
         {
            return null;
         }
         if(_loc22_ != null)
         {
            _loc10_ = getPalette(_loc22_.paletteID);
            if(!_loc10_)
            {
               return null;
            }
            _loc13_ = figureData.getColourIds(param2);
            if(!_loc13_)
            {
               _loc13_ = [];
            }
            _loc12_ = new Array(_loc13_.length);
            _loc19_ = showClubItemsDimmedConfiguration();
            for each(var _loc28_ in _loc10_.colors)
            {
               if(_loc28_.isSelectable && (_loc19_ || clubMemberLevel >= _loc28_.clubLevel))
               {
                  _loc11_ = 0;
                  while(_loc11_ < 2)
                  {
                     _loc15_ = clubMemberLevel < _loc28_.clubLevel;
                     _loc18_ = new AvatarEditorGridColorItem(AvatarEditorView.COLOUR_WINDOW.clone() as IWindowController_1,param1,_loc28_,_loc15_);
                     _loc8_[_loc11_].push(_loc18_);
                     _loc11_++;
                  }
                  if(param2 != "hd")
                  {
                     _loc26_ = 0;
                     while(_loc26_ < _loc13_.length)
                     {
                        if(_loc28_.id == _loc13_[_loc26_])
                        {
                           _loc12_[_loc26_] = _loc28_;
                        }
                        _loc26_++;
                     }
                  }
               }
            }
            if(_loc19_)
            {
               _loc17_ = 2;
               _loc30_ = _manager.avatarRenderManager.getMandatoryAvatarPartSetIds(gender,_loc17_);
            }
            else
            {
               _loc30_ = _manager.avatarRenderManager.getMandatoryAvatarPartSetIds(gender,clubMemberLevel);
            }
            _loc32_ = _loc30_.indexOf(param2) == -1;
            if(_loc32_)
            {
               _loc33_ = _manager.windowManager.assets.getAssetByName("avatar_editor_generic_remove_selection") as BitmapDataAsset;
               _loc25_ = (_loc33_.content as BitmapData).clone();
               _loc24_ = AvatarEditorView.THUMB_WINDOW.clone() as IWindowController_1;
               _loc24_.name = "REMOVE_ITEM";
               _loc9_ = new AvatarEditorGridPartItem(_loc24_,param1,null,null,false);
               _loc9_.iconImage = _loc25_;
               _loc4_.push(_loc9_);
            }
            _loc29_ = param2 != "hd";
            _loc31_ = _loc22_.partSets;
            _loc16_ = int(_loc31_.length);
            _loc27_ = _loc16_ - 1;
            while(_loc27_ >= 0)
            {
               _loc14_ = _loc31_.getWithIndex(_loc27_);
               _loc6_ = false;
               if(_loc14_.gender == "U")
               {
                  _loc6_ = true;
               }
               else if(_loc14_.gender == gender)
               {
                  _loc6_ = true;
               }
               if(_loc14_.isSelectable && _loc6_ && (_loc19_ || clubMemberLevel >= _loc14_.clubLevel))
               {
                  _loc34_ = clubMemberLevel < _loc14_.clubLevel;
                  _loc3_ = true;
                  if(_loc14_.isSellable)
                  {
                     _loc3_ = manager.inventory && _manager.inventory.hasFigureSetIdInInventory(_loc14_.id) || isDevelopmentEditor();
                  }
                  if(_loc3_)
                  {
                     _loc9_ = new AvatarEditorGridPartItem(AvatarEditorView.THUMB_WINDOW.clone() as IWindowController_1,param1,_loc14_,_loc12_,_loc29_,_loc34_);
                     _loc4_.push(_loc9_);
                  }
               }
               _loc27_--;
            }
         }
         _loc4_.sort(showClubItemsFirst ? orderByClubDesc : orderByClubAsc);
         if(UnknownVarFromHabboAvatarEditor_Boolean_3 || _manager.getBoolean("avatareditor.support.sellablefurni"))
         {
            _loc20_ = _manager.windowManager.assets.getAssetByName("camera_zoom_in") as BitmapDataAsset;
            _loc23_ = (_loc20_.content as BitmapData).clone();
            _loc7_ = AvatarEditorView.THUMB_WINDOW.clone() as IWindowController_1;
            _loc7_.name = "GET_MORE";
            _loc9_ = new AvatarEditorGridPartItem(_loc7_,param1,null,null,false);
            _loc9_.iconImage = _loc23_;
            _loc4_.push(_loc9_);
         }
         _loc21_ = 0;
         while(_loc21_ < 2)
         {
            _loc5_ = _loc8_[_loc21_] as Array;
            _loc5_.sort(orderPaletteByClub);
            _loc21_++;
         }
         return new CategoryData(_loc4_,_loc8_);
      }
      
      public function isSideContentEnabled() : Boolean
      {
         return _isSideContentEnabled;
      }
      
      public function hasInvalidClubItems() : Boolean
      {
         var _loc1_:Boolean = false;
         for each(var _loc2_ in getCategoryValues())
         {
            if(_loc2_ != null)
            {
               _loc1_ = _loc2_.hasClubItemsOverLevel(clubMemberLevel);
               if(_loc1_)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function hasInvalidSellableItems() : Boolean
      {
         var _loc1_:Boolean = false;
         for each(var _loc2_ in getCategoryValues())
         {
            if(_loc2_ != null)
            {
               _loc1_ = _loc2_.hasInvalidSellableItems(_manager.inventory);
               if(_loc1_)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function stripClubItems() : void
      {
         for each(var _loc1_ in getCategoryValues())
         {
            if(_loc1_ != null)
            {
               _loc1_.stripClubItemsOverLevel(clubMemberLevel);
            }
         }
         figureData.updateView();
      }
      
      public function stripInvalidSellableItems() : void
      {
         for each(var _loc1_ in getCategoryValues())
         {
            if(_loc1_ != null)
            {
               _loc1_.stripInvalidSellableItems();
            }
         }
         figureData.updateView();
      }
      
      private function getCategoryValues() : Array
      {
         if(_categories == null)
         {
            return [];
         }
         var _loc1_:Array = _categories.getValues();
         return _loc1_ ?? [];
      }
      
      public function getDefaultColour(param1:String) : int
      {
         var _loc3_:IPalette = null;
         var _loc2_:ISetType = getFigureSetType(param1);
         if(_loc2_ != null)
         {
            _loc3_ = getPalette(_loc2_.paletteID);
            for each(var _loc4_ in _loc3_.colors)
            {
               if(_loc4_.isSelectable && clubMemberLevel >= _loc4_.clubLevel)
               {
                  return _loc4_.id;
               }
            }
         }
         return -1;
      }
      
      private function orderByClubAsc(param1:AvatarEditorGridPartItem, param2:AvatarEditorGridPartItem) : Number
      {
         var _loc4_:Number = param1.partSet?.clubLevel;
         var _loc5_:Number = param2.partSet?.clubLevel;
         var _loc6_:Boolean = param1.partSet?.isSellable;
         var _loc3_:Boolean = param2.partSet?.isSellable;
         if(_loc6_ && !_loc3_)
         {
            return 1;
         }
         if(_loc3_ && !_loc6_)
         {
            return -1;
         }
         if(_loc4_ < _loc5_)
         {
            return -1;
         }
         if(_loc4_ > _loc5_)
         {
            return 1;
         }
         if(param1.partSet.id < param2.partSet.id)
         {
            return -1;
         }
         if(param1.partSet.id > param2.partSet.id)
         {
            return 1;
         }
         return 0;
      }
      
      private function orderByClubDesc(param1:AvatarEditorGridPartItem, param2:AvatarEditorGridPartItem) : Number
      {
         var _loc4_:Number = param1.partSet?.clubLevel;
         var _loc5_:Number = param2.partSet?.clubLevel;
         var _loc6_:Boolean = param1.partSet?.isSellable;
         var _loc3_:Boolean = param2.partSet?.isSellable;
         if(_loc6_ && !_loc3_)
         {
            return 1;
         }
         if(_loc3_ && !_loc6_)
         {
            return -1;
         }
         if(_loc4_ > _loc5_)
         {
            return -1;
         }
         if(_loc4_ < _loc5_)
         {
            return 1;
         }
         if(param1.partSet.id > param2.partSet.id)
         {
            return -1;
         }
         if(param1.partSet.id < param2.partSet.id)
         {
            return 1;
         }
         return 0;
      }
      
      private function orderPaletteByClub(param1:AvatarEditorGridColorItem, param2:AvatarEditorGridColorItem) : Number
      {
         var _loc3_:Number = param1.partColor == null ? -1 : param1.partColor.clubLevel as Number;
         var _loc4_:Number = param2.partColor == null ? -1 : param2.partColor.clubLevel as Number;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.partColor.index < param2.partColor.index)
         {
            return -1;
         }
         if(param1.partColor.index > param2.partColor.index)
         {
            return 1;
         }
         return 0;
      }
      
      public function get gender() : String
      {
         return _gender;
      }
      
      public function set gender(param1:String) : void
      {
         if(_gender == param1)
         {
            return;
         }
         _gender = param1;
         for each(var _loc2_ in _categories)
         {
            _loc2_.reset();
         }
         if(_view != null)
         {
            _view.update();
         }
      }
      
      public function get handler() : AvatarEditorMessageHandler
      {
         return _manager.handler;
      }
      
      public function get wardrobe() : WardrobeModel
      {
         if(!UnknownVarFromHabboAvatarEditor_Boolean_1)
         {
            return null;
         }
         return UnknownVarFromHabboAvatarEditor_Map_1.getValue("wardrobe");
      }
      
      public function get effects() : EffectsModel
      {
         if(!UnknownVarFromHabboAvatarEditor_Boolean_1)
         {
            return null;
         }
         return _categories.getValue("effects");
      }
      
      public function set clubMemberLevel(param1:int) : void
      {
         UnknownVarFromHabboAvatarEditor_Int_1 = param1;
      }
      
      public function get clubMemberLevel() : int
      {
         if(this.isDevelopmentEditor() == true)
         {
            return 3;
         }
         if(!UnknownVarFromHabboAvatarEditor_Int_1)
         {
            return _manager.sessionData.clubLevel;
         }
         return UnknownVarFromHabboAvatarEditor_Int_1;
      }
      
      public function verifyClubLevel() : Boolean
      {
         return _manager.catalog.verifyClubLevel();
      }
      
      private function get showClubItemsFirst() : Boolean
      {
         return _manager.getBoolean("avatareditor.show.clubitems.first");
      }
      
      private function showClubItemsDimmedConfiguration() : Boolean
      {
         return _manager.getBoolean("avatareditor.show.clubitems.dimmed");
      }
      
      public function get manager() : HabboAvatarEditorManager
      {
         return _manager;
      }
      
      public function update() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         for each(_loc1_ in _categories)
         {
            _loc1_.reset();
         }
         for each(_loc2_ in UnknownVarFromHabboAvatarEditor_Map_1)
         {
            _loc2_.reset();
         }
         if(_view)
         {
            _view.update();
         }
      }
      
      public function setAvatarEffectType(param1:int) : void
      {
         figureData.avatarEffectType = param1;
         figureData.updateView();
         UnknownVarFromHabboAvatarEditor_Boolean_2 = true;
      }
      
      public function setNftOutfit(param1:NftOutfit) : void
      {
         _setNftOutfit = param1;
         UnknownVarFromHabboAvatarEditor_String_4 = figureData.getFigureString();
         UnknownVarFromHabboAvatarEditor_String_5 = figureData.gender;
      }
      
      public function hasSetNftOutfitInViewer() : Boolean
      {
         return _setNftOutfit != null;
      }
      
      public function loadNftFigure() : void
      {
         var _loc1_:NftAvatarsModel = null;
         var _loc2_:NftOutfit = null;
         if(_setNftOutfit)
         {
            loadAvatarInEditor(_setNftOutfit.figure,_setNftOutfit.gender,UnknownVarFromHabboAvatarEditor_Int_1);
         }
         else if(UnknownVarFromHabboAvatarEditor_String_1 != null)
         {
            _loc1_ = _categories.getValue("nfts");
            if(_loc1_)
            {
               _loc2_ = _loc1_.getNftAvatarByTokenId(UnknownVarFromHabboAvatarEditor_String_1);
               if(_loc2_)
               {
                  setNftOutfit(_loc2_);
                  loadAvatarInEditor(_loc2_.figure,_loc2_.gender,UnknownVarFromHabboAvatarEditor_Int_1);
               }
            }
         }
      }
      
      public function loadRollbackFigure() : void
      {
         if(_setNftOutfit)
         {
            loadAvatarInEditor(UnknownVarFromHabboAvatarEditor_String_4,UnknownVarFromHabboAvatarEditor_String_5,UnknownVarFromHabboAvatarEditor_Int_1);
         }
      }
      
      public function loadFallbackFigure() : void
      {
         if(UnknownVarFromHabboAvatarEditor_String_2)
         {
            loadAvatarInEditor(UnknownVarFromHabboAvatarEditor_String_2,UnknownVarFromHabboAvatarEditor_String_3,UnknownVarFromHabboAvatarEditor_Int_1);
         }
      }
      
      public function hasNftOutfit() : Boolean
      {
         return UnknownVarFromHabboAvatarEditor_String_1 != null;
      }
      
      public function get view() : AvatarEditorView
      {
         return _view;
      }
      
      public function openHabboClubAdWindow() : void
      {
         if(_manager.catalog)
         {
            _manager.catalog.openClubCenter();
         }
      }
      
      public function isDevelopmentEditor() : Boolean
      {
         return _instanceId == 3;
      }
   }
}

