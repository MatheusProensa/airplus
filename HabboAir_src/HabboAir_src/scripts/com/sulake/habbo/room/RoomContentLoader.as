package com.sulake.habbo.room
{
   import com.sulake.core.Core;
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.core.runtime.IComponent_1;
   import com.sulake.core.utils.LibraryLoader;
   import com.sulake.core.utils.Map;
   import com.sulake.core.utils.UnknownICoreUtils1;
   import com.sulake.habbo.room.object.RoomObjectUserTypes;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.furniture.IFurnitureData;
   import com.sulake.habbo.session.furniture.UnknownIHabboSessionFurniture1;
   import com.sulake.habbo.utils.StringUtil;
   import com.sulake.room.IRoomContentLoader;
   import com.sulake.room.events.RoomContentLoadedEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.object.IRoomObjectVisualizationFactory;
   import com.sulake.room.object.visualization.utils.IGraphicAssetCollection;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   [SecureSWF(rename="true")]
   public class RoomContentLoader implements IRoomContentLoader, UnknownIHabboSessionFurniture1, IComponentInterfaceQueue
   {
      public static const CONTENT_LOADER_READY:String = "RCL_LOADER_READY";
      
      private static const ASSET_LIBRARY_NAME_PREFIX:String = "RoomContentLoader ";
      
      private static const STATE_CREATED:int = 0;
      
      private static const STATE_INITIALIZING:int = 1;
      
      private static const STATE_READY:int = 2;
      
      private static const PLACE_HOLDER_FURNITURE:String = "place_holder";
      
      private static const PLACE_HOLDER_WALL_ITEM:String = "wall_place_holder";
      
      private static const PLACE_HOLDER_PET:String = "pet_place_holder";
      
      private static const PLACE_HOLDER_DEFAULT:String = "place_holder";
      
      private static const ROOM_CONTENT:String = "room";
      
      private static const UnknownConstFromRoomContentLoader_String_1:String = "tile_cursor";
      
      private static const UnknownConstFromRoomContentLoader_String_2:String = "selection_arrow";
      
      private static const CONTENT_DROP_DELAY:int = 20000;
      
      private static const COMPRESSION_INTERVAL:int = 30000;
      
      private static const PLACE_HOLDER_TYPES:Array = ["place_holder","wall_place_holder","pet_place_holder","room","tile_cursor","selection_arrow"];
      
      private static const PLACE_HOLDER_TYPES_GPU:Array = ["place_holder","wall_place_holder","pet_place_holder","room","selection_arrow"];
      
      private var UnknownVarFromRoomContentLoader_String_1:String;
      
      private var _libraries:Map = null;
      
      private var UnknownVarFromRoomContentLoader_Map_1:Map = null;
      
      private var _additionalObjectTypeLibraries:Map = null;
      
      private var UnknownVarFromRoomContentLoader_Map_2:Map = null;
      
      private var _visualizationFactory:IRoomObjectVisualizationFactory = null;
      
      private var UnknownVarFromRoomContentLoader_Int_1:int = 0;
      
      private var _stateEvents:IEventDispatcher = null;
      
      private var _disposed:Boolean = false;
      
      private var UnknownVarFromRoomContentLoader_Boolean_1:Boolean = false;
      
      private var _activeObjectTypes:Map = null;
      
      private var UnknownVarFromRoomContentLoader_Dictionary_1:Dictionary = new Dictionary();
      
      private var UnknownVarFromRoomContentLoader_Map_3:Map = null;
      
      private var _wallItemTypes:Map = null;
      
      private var _wallItems:Dictionary = new Dictionary();
      
      private var UnknownVarFromRoomContentLoader_Map_4:Map = null;
      
      private var _petTypes:Map = null;
      
      private var UnknownVarFromRoomContentLoader_Dictionary_2:Dictionary = new Dictionary();
      
      private var _petColors:Map = null;
      
      private var _petLayers:Map = null;
      
      private var UnknownVarFromRoomContentLoader_Map_5:Map = null;
      
      private var _objectAliases:Map = null;
      
      private var _objectOriginalNames:Map = null;
      
      private var UnknownVarFromRoomContentLoader_Map_6:Map = null;
      
      private var UnknownVarFromRoomContentLoader_String_2:String;
      
      private var UnknownVarFromRoomContentLoader_String_3:String;
      
      private var UnknownVarFromRoomContentLoader_String_4:String;
      
      private var UnknownVarFromRoomContentLoader_String_5:String;
      
      private var UnknownVarFromRoomContentLoader_String_6:String;
      
      private var UnknownVarFromRoomContentLoader_Boolean_2:Boolean = false;
      
      private var _lastAssetCompressionTime:uint;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var UnknownVarFromRoomContentLoader_IAssetLibraryCollection_1:IAssetLibraryCollection;
      
      private var UnknownVarFromRoomContentLoader_IRoomEngine_3_1:IRoomEngine_3;
      
      private var UnknownVarFromRoomContentLoader_IComponent_1_1:IComponent_1;
      
      private var _ignoredFurniTypes:Array;
      
      public function RoomContentLoader(param1:String)
      {
         super();
         UnknownVarFromRoomContentLoader_String_1 = param1;
         _libraries = new Map();
         UnknownVarFromRoomContentLoader_Map_1 = new Map();
         _activeObjectTypes = new Map();
         UnknownVarFromRoomContentLoader_Map_3 = new Map();
         _wallItemTypes = new Map();
         UnknownVarFromRoomContentLoader_Map_4 = new Map();
         _petTypes = new Map();
         UnknownVarFromRoomContentLoader_Map_6 = new Map();
         UnknownVarFromRoomContentLoader_Map_5 = new Map();
         _objectAliases = new Map();
         _objectOriginalNames = new Map();
         UnknownVarFromRoomContentLoader_Map_2 = new Map();
         _additionalObjectTypeLibraries = new Map();
      }
      
      private function get fileProxy() : UnknownICoreUtils1
      {
         return Core.instance.fileProxy;
      }
      
      public function set sessionDataManager(param1:ISessionDataManager) : void
      {
         _sessionDataManager = param1;
         if(UnknownVarFromRoomContentLoader_Boolean_2)
         {
            UnknownVarFromRoomContentLoader_Boolean_2 = false;
            initFurnitureData();
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set visualizationFactory(param1:IRoomObjectVisualizationFactory) : void
      {
         _visualizationFactory = param1;
      }
      
      public function initialize(param1:IEventDispatcher, param2:IComponent_1) : void
      {
         _stateEvents = param1;
         UnknownVarFromRoomContentLoader_String_2 = param2.getProperty("flash.dynamic.download.url");
         UnknownVarFromRoomContentLoader_String_3 = param2.getProperty("flash.dynamic.download.name.template");
         UnknownVarFromRoomContentLoader_String_4 = param2.getProperty("flash.dynamic.icon.download.name.template");
         UnknownVarFromRoomContentLoader_String_5 = param2.getProperty("pet.dynamic.download.url");
         UnknownVarFromRoomContentLoader_String_6 = param2.getProperty("pet.dynamic.download.name.template");
         UnknownVarFromRoomContentLoader_IComponent_1_1 = param2;
         UnknownVarFromRoomContentLoader_Int_1 = 1;
         initFurnitureData();
         initPetData(param2);
      }
      
      private function initPetData(param1:IComponent_1) : void
      {
         var _loc2_:Array = param1.getProperty("pet.configuration").split(",");
         var _loc3_:int = 0;
         for each(var _loc4_ in _loc2_)
         {
            UnknownVarFromRoomContentLoader_Dictionary_2[_loc4_] = _loc3_;
            _petTypes.add(_loc3_,_loc4_);
            _loc3_++;
         }
         _petColors = new Map();
         _petLayers = new Map();
      }
      
      private function initFurnitureData() : void
      {
         if(_sessionDataManager == null)
         {
            UnknownVarFromRoomContentLoader_Boolean_2 = true;
            return;
         }
         var _loc1_:Vector.<IFurnitureData> = _sessionDataManager.getFurniData(this);
         if(_loc1_ == null)
         {
            return;
         }
         _sessionDataManager.removeFurniDataListener(this);
         populateFurniData(_loc1_);
         UnknownVarFromRoomContentLoader_Boolean_1 = true;
         parseIgnoredFurniTypes();
         continueInitilization();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:AssetLibrary = null;
         var _loc4_:IGraphicAssetCollection = null;
         var _loc5_:String = null;
         if(_libraries != null)
         {
            _loc2_ = int(_libraries.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_ = _libraries.getWithIndex(_loc3_) as AssetLibrary;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc3_++;
            }
            _libraries.dispose();
            _libraries = null;
         }
         if(UnknownVarFromRoomContentLoader_Map_1 != null)
         {
            UnknownVarFromRoomContentLoader_Map_1.dispose();
            UnknownVarFromRoomContentLoader_Map_1 = null;
         }
         if(_activeObjectTypes != null)
         {
            _activeObjectTypes.dispose();
            _activeObjectTypes = null;
         }
         if(UnknownVarFromRoomContentLoader_Map_3)
         {
            UnknownVarFromRoomContentLoader_Map_3.dispose();
            UnknownVarFromRoomContentLoader_Map_3 = null;
         }
         if(_wallItemTypes != null)
         {
            _wallItemTypes.dispose();
            _wallItemTypes = null;
         }
         if(UnknownVarFromRoomContentLoader_Map_4)
         {
            UnknownVarFromRoomContentLoader_Map_4.dispose();
            UnknownVarFromRoomContentLoader_Map_4 = null;
         }
         if(_petTypes != null)
         {
            _petTypes.dispose();
            _petTypes = null;
         }
         if(_petColors != null)
         {
            _petColors.dispose();
            _petColors = null;
         }
         if(_petLayers != null)
         {
            _petLayers.dispose();
            _petLayers = null;
         }
         if(UnknownVarFromRoomContentLoader_Map_5 != null)
         {
            UnknownVarFromRoomContentLoader_Map_5.dispose();
            UnknownVarFromRoomContentLoader_Map_5 = null;
         }
         if(_objectAliases != null)
         {
            _objectAliases.dispose();
            _objectAliases = null;
         }
         if(_objectOriginalNames != null)
         {
            _objectOriginalNames.dispose();
            _objectOriginalNames = null;
         }
         if(UnknownVarFromRoomContentLoader_Map_6 != null)
         {
            UnknownVarFromRoomContentLoader_Map_6.dispose();
            UnknownVarFromRoomContentLoader_Map_6 = null;
         }
         if(UnknownVarFromRoomContentLoader_Map_2 != null)
         {
            _loc2_ = int(UnknownVarFromRoomContentLoader_Map_2.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = UnknownVarFromRoomContentLoader_Map_2.getWithIndex(_loc3_) as IGraphicAssetCollection;
               if(_loc4_ != null)
               {
                  _loc4_.dispose();
               }
               _loc3_++;
            }
            UnknownVarFromRoomContentLoader_Map_2.dispose();
            UnknownVarFromRoomContentLoader_Map_2 = null;
         }
         if(_additionalObjectTypeLibraries != null)
         {
            _additionalObjectTypeLibraries.dispose();
            _additionalObjectTypeLibraries = null;
         }
         if(UnknownVarFromRoomContentLoader_Dictionary_1 != null)
         {
            for(_loc5_ in UnknownVarFromRoomContentLoader_Dictionary_1)
            {
               delete UnknownVarFromRoomContentLoader_Dictionary_1[_loc5_];
            }
            UnknownVarFromRoomContentLoader_Dictionary_1 = null;
         }
         if(_wallItems != null)
         {
            for(_loc5_ in _wallItems)
            {
               delete _wallItems[_loc5_];
            }
            _wallItems = null;
         }
         if(UnknownVarFromRoomContentLoader_Dictionary_2 != null)
         {
            for(_loc5_ in UnknownVarFromRoomContentLoader_Dictionary_2)
            {
               delete UnknownVarFromRoomContentLoader_Dictionary_2[_loc5_];
            }
            UnknownVarFromRoomContentLoader_Dictionary_2 = null;
         }
         _stateEvents = null;
         _sessionDataManager = null;
         UnknownVarFromRoomContentLoader_IComponent_1_1 = null;
         _disposed = true;
      }
      
      private function parseIgnoredFurniTypes() : void
      {
         var _loc3_:int = 0;
         var _loc1_:String = UnknownVarFromRoomContentLoader_IComponent_1_1.getProperty("gpu.ignored_furni");
         if(!_loc1_)
         {
            return;
         }
         _ignoredFurniTypes = _loc1_.split(",");
         var _loc2_:int = int(_ignoredFurniTypes.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _ignoredFurniTypes[_loc3_] = StringUtil.trim(_ignoredFurniTypes[_loc3_]);
            _loc3_++;
         }
      }
      
      private function isIgnoredFurniType(param1:String) : Boolean
      {
         return !!_ignoredFurniTypes ? _ignoredFurniTypes.indexOf(param1) != -1 : false;
      }
      
      private function populateFurniData(param1:Vector.<IFurnitureData>) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc6_:String = null;
         var _loc8_:int = 0;
         var _loc2_:String = null;
         var _loc7_:String = null;
         var _loc5_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc4_ = _loc3_.id;
            _loc6_ = _loc3_.className;
            if(_loc3_.hasIndexedColor)
            {
               _loc6_ = _loc6_ + "*" + _loc3_.colourIndex;
            }
            _loc8_ = _loc3_.revision;
            _loc2_ = _loc3_.adUrl;
            if(_loc2_ != null && _loc2_.length > 0)
            {
               UnknownVarFromRoomContentLoader_Map_6.add(_loc6_,_loc2_);
            }
            _loc7_ = _loc3_.className;
            if(_loc3_.type == "s")
            {
               _activeObjectTypes.add(_loc4_,_loc6_);
               UnknownVarFromRoomContentLoader_Map_3.add(_loc6_,_loc4_);
               if(UnknownVarFromRoomContentLoader_Dictionary_1[_loc7_] == null)
               {
                  UnknownVarFromRoomContentLoader_Dictionary_1[_loc7_] = 1;
               }
            }
            else if(_loc3_.type == "i")
            {
               if(_loc6_ == "post.it")
               {
                  _loc6_ = "post_it";
                  _loc7_ = "post_it";
               }
               if(_loc6_ == "post.it.vd")
               {
                  _loc6_ = "post_it_vd";
                  _loc7_ = "post_it_vd";
               }
               _wallItemTypes.add(_loc4_,_loc6_);
               UnknownVarFromRoomContentLoader_Map_4.add(_loc6_,_loc4_);
               if(_wallItems[_loc7_] == null)
               {
                  _wallItems[_loc7_] = 1;
               }
            }
            _loc5_ = UnknownVarFromRoomContentLoader_Map_5.getValue(_loc7_);
            if(_loc8_ > _loc5_)
            {
               UnknownVarFromRoomContentLoader_Map_5.remove(_loc7_);
               UnknownVarFromRoomContentLoader_Map_5.add(_loc7_,_loc8_);
            }
         }
      }
      
      private function continueInitilization() : void
      {
         if(UnknownVarFromRoomContentLoader_Boolean_1)
         {
            UnknownVarFromRoomContentLoader_Int_1 = 2;
            if(_stateEvents != null)
            {
               _stateEvents.dispatchEvent(new Event("RCL_LOADER_READY"));
            }
         }
      }
      
      public function setRoomObjectAlias(param1:String, param2:String) : void
      {
         if(_objectAliases != null)
         {
            _objectAliases.remove(param1);
            _objectAliases.add(param1,param2);
         }
         if(_objectOriginalNames != null)
         {
            _objectOriginalNames.remove(param2);
            _objectOriginalNames.add(param2,param1);
         }
      }
      
      private function getRoomObjectAlias(param1:String) : String
      {
         var _loc2_:* = null;
         if(_objectAliases != null)
         {
            _loc2_ = _objectAliases.getValue(param1) as String;
         }
         if(_loc2_ == null)
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      private function getRoomObjectOriginalName(param1:String) : String
      {
         var _loc2_:* = null;
         if(_objectOriginalNames != null)
         {
            _loc2_ = _objectOriginalNames.getValue(param1) as String;
         }
         if(_loc2_ == null)
         {
            _loc2_ = param1;
         }
         return _loc2_;
      }
      
      public function getObjectCategory(param1:String) : int
      {
         if(param1 == null)
         {
            return -2;
         }
         if(UnknownVarFromRoomContentLoader_Dictionary_1[param1] != null)
         {
            return 10;
         }
         if(_wallItems[param1] != null)
         {
            return 20;
         }
         if(UnknownVarFromRoomContentLoader_Dictionary_2[param1] != null)
         {
            return 100;
         }
         if(param1.indexOf("poster") == 0)
         {
            return 20;
         }
         if(param1 == "room")
         {
            return 0;
         }
         if(param1 == "user")
         {
            return 100;
         }
         if(param1 == "pet")
         {
            return 100;
         }
         if(param1 == "bot")
         {
            return 100;
         }
         if(param1 == "rentable_bot")
         {
            return 100;
         }
         if(param1 == "tile_cursor" || param1 == "selection_arrow")
         {
            return 200;
         }
         return -2;
      }
      
      public function getPlaceHolderType(param1:String) : String
      {
         if(UnknownVarFromRoomContentLoader_Dictionary_1[param1] != null)
         {
            return "place_holder";
         }
         if(_wallItems[param1] != null)
         {
            return "wall_place_holder";
         }
         if(UnknownVarFromRoomContentLoader_Dictionary_2[param1] != null)
         {
            return "pet_place_holder";
         }
         return "place_holder";
      }
      
      public function getPlaceHolderTypes() : Array
      {
         return PLACE_HOLDER_TYPES;
      }
      
      public function getActiveObjectType(param1:int) : String
      {
         var _loc2_:String = _activeObjectTypes.getValue(param1) as String;
         if(_loc2_ == null)
         {
            Logger.log("[RoomContentLoader] Could not find type for id: " + param1);
         }
         return getObjectType(_loc2_);
      }
      
      public function getActiveObjectTypeId(param1:String) : int
      {
         return UnknownVarFromRoomContentLoader_Map_3.getValue(param1);
      }
      
      public function getWallItemType(param1:int, param2:String = null) : String
      {
         var _loc3_:String = _wallItemTypes.getValue(param1) as String;
         if(_loc3_ == "poster" && param2 != null)
         {
            _loc3_ += param2;
         }
         return getObjectType(_loc3_);
      }
      
      public function getWallItemTypeId(param1:String) : int
      {
         return UnknownVarFromRoomContentLoader_Map_4.getValue(param1);
      }
      
      public function getPetType(param1:int) : String
      {
         return _petTypes.getValue(param1) as String;
      }
      
      public function getPetTypeId(param1:String) : int
      {
         return UnknownVarFromRoomContentLoader_Dictionary_2[param1];
      }
      
      public function getPetColor(param1:int, param2:int) : PetColorResult
      {
         var _loc3_:Map = _petColors[param1];
         if(_loc3_ != null)
         {
            return _loc3_[param2] as PetColorResult;
         }
         return null;
      }
      
      public function getPetColorsByTag(param1:int, param2:String) : Array
      {
         var _loc5_:Map = _petColors[param1];
         var _loc3_:Array = [];
         if(_loc5_ != null)
         {
            for each(var _loc4_ in _loc5_.getValues())
            {
               if(_loc4_.tag == param2)
               {
                  _loc3_.push(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      public function getPetLayerIdForTag(param1:int, param2:String, param3:int = 64) : int
      {
         var _loc5_:Dictionary = null;
         var _loc4_:Map = _petLayers[param1];
         if(_loc4_)
         {
            _loc5_ = _loc4_[param3.toString()];
            if(_loc5_)
            {
               return _loc5_[param2] ?? -1;
            }
         }
         return -1;
      }
      
      public function getPetDefaultPalette(param1:int, param2:String) : PetColorResult
      {
         var _loc4_:Map = _petColors[param1];
         if(_loc4_ != null)
         {
            for each(var _loc3_ in _loc4_.getValues())
            {
               if(_loc3_.layerTags.indexOf(param2) > -1 && _loc3_.isMaster)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public function getActiveObjectColorIndex(param1:int) : int
      {
         var _loc2_:String = _activeObjectTypes.getValue(param1) as String;
         return getObjectColorIndex(_loc2_);
      }
      
      public function getWallItemColorIndex(param1:int) : int
      {
         var _loc2_:String = _wallItemTypes.getValue(param1) as String;
         return getObjectColorIndex(_loc2_);
      }
      
      public function getRoomObjectAdURL(param1:String) : String
      {
         if(UnknownVarFromRoomContentLoader_Map_6.getValue(param1) != null)
         {
            return UnknownVarFromRoomContentLoader_Map_6.getValue(param1);
         }
         return "";
      }
      
      private function getObjectType(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:int = int(param1.indexOf("*"));
         if(_loc2_ >= 0)
         {
            param1 = param1.substr(0,_loc2_);
         }
         return param1;
      }
      
      private function getObjectColorIndex(param1:String) : int
      {
         if(param1 == null)
         {
            return -1;
         }
         var _loc3_:int = 0;
         var _loc2_:int = int(param1.indexOf("*"));
         if(_loc2_ >= 0)
         {
            _loc3_ = int(param1.substr(_loc2_ + 1));
         }
         return _loc3_;
      }
      
      public function getContentType(param1:String) : String
      {
         return param1;
      }
      
      public function hasInternalContent(param1:String) : Boolean
      {
         param1 = RoomObjectUserTypes.getVisualizationType(param1);
         if(param1 == "user" || param1 == "game_snowball" || param1 == "game_snowsplash")
         {
            return true;
         }
         return false;
      }
      
      private function getObjectRevision(param1:String) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = getObjectCategory(param1);
         if(_loc2_ == 10 || _loc2_ == 20)
         {
            if(param1.indexOf("poster") == 0)
            {
               param1 = "poster";
            }
            return UnknownVarFromRoomContentLoader_Map_5.getValue(param1);
         }
         return 0;
      }
      
      private function getObjectContentURLs(param1:String, param2:String = null, param3:Boolean = false) : Array
      {
         var _loc6_:int = 0;
         var _loc4_:String = null;
         var _loc8_:* = null;
         var _loc10_:int = 0;
         var _loc5_:Boolean = false;
         var _loc9_:String = null;
         var _loc7_:String;
         switch(_loc7_ = getContentType(param1))
         {
            case "place_holder":
               return [resolveLocalOrAssetBaseUrl("PlaceHolderFurniture.swf")];
            case "wall_place_holder":
               return [resolveLocalOrAssetBaseUrl("PlaceHolderWallItem.swf")];
            case "pet_place_holder":
               return [resolveLocalOrAssetBaseUrl("PlaceHolderPet.swf")];
            case "room":
               return [resolveLocalOrAssetBaseUrl("HabboRoomContent.swf")];
            case "tile_cursor":
               return [resolveLocalOrAssetBaseUrl("TileCursor.swf")];
            case "selection_arrow":
               return [resolveLocalOrAssetBaseUrl("SelectionArrow.swf")];
            default:
               _loc6_ = getObjectCategory(_loc7_);
               if(_loc6_ == 10 || _loc6_ == 20)
               {
                  _loc4_ = getRoomObjectAlias(_loc7_);
                  _loc8_ = param3 ? UnknownVarFromRoomContentLoader_String_4 : UnknownVarFromRoomContentLoader_String_3;
                  _loc8_ = _loc8_.replace(/%typeid%/,_loc4_);
                  _loc10_ = getObjectRevision(_loc7_);
                  _loc8_ = _loc8_.replace(/%revision%/,_loc10_);
                  if(param3)
                  {
                     _loc5_ = param2 != null && param2 != "" && UnknownVarFromRoomContentLoader_Map_3.hasKey(param1 + "*" + param2);
                     _loc8_ = _loc8_.replace(/%param%/,_loc5_ ? "_" + param2 : "");
                  }
                  if(_loc8_.indexOf("present_wrap") >= 0 && _loc8_.indexOf("_icon.png") >= 0)
                  {
                     _loc8_ = _loc8_.substring(0,_loc8_.indexOf("present_wrap")) + "present_wrap_1_icon.png";
                  }
                  return [UnknownVarFromRoomContentLoader_String_2 + _loc8_];
               }
               if(_loc6_ == 100)
               {
                  _loc9_ = UnknownVarFromRoomContentLoader_String_5 + UnknownVarFromRoomContentLoader_String_6;
                  _loc9_ = _loc9_.replace(/%type%/,_loc7_);
                  return [_loc9_];
               }
               return [];
         }
      }
      
      private function resolveLocalOrAssetBaseUrl(param1:String) : String
      {
         var _loc2_:* = null;
         if(fileProxy && fileProxy.localFileExists(param1))
         {
            return fileProxy.localFilePath(param1);
         }
         return UnknownVarFromRoomContentLoader_String_5 + param1;
      }
      
      public function insertObjectContent(param1:int, param2:int, param3:IAssetLibraryCollection) : Boolean
      {
         var _loc6_:Event = null;
         var _loc7_:IEventDispatcher = null;
         var _loc5_:String = getAssetLibraryType(param3);
         switch(param2 - 10)
         {
            case 0:
               _activeObjectTypes[param1] = _loc5_;
               UnknownVarFromRoomContentLoader_Map_3.add(_loc5_,param1);
               break;
            case 10:
               _wallItemTypes[param1] = _loc5_;
               break;
            default:
               throw new Error("Registering content library for unsupported category " + param2 + "!");
         }
         var _loc4_:AssetLibraryCollection = addAssetLibraryCollection(_loc5_,null) as AssetLibraryCollection;
         if(_loc4_)
         {
            _loc4_.addAssetLibrary(param3);
            if(initializeGraphicAssetCollection(_loc5_,param3))
            {
               switch(param2 - 10)
               {
                  case 0:
                     if(UnknownVarFromRoomContentLoader_Dictionary_1[_loc5_] == null)
                     {
                        UnknownVarFromRoomContentLoader_Dictionary_1[_loc5_] = 1;
                     }
                     break;
                  case 10:
                     if(_wallItems[_loc5_] == null)
                     {
                        _wallItems[_loc5_] = 1;
                     }
                     break;
                  default:
                     throw new Error("Registering content library for unsupported category " + param2 + "!");
               }
               _loc6_ = new RoomContentLoadedEvent("RCLE_SUCCESS",_loc5_);
               _loc7_ = getAssetLibraryEventDispatcher(_loc5_,true);
               if(_loc7_)
               {
                  _loc7_.dispatchEvent(_loc6_);
               }
               return true;
            }
         }
         return false;
      }
      
      public function getObjectUrl(param1:String, param2:String) : String
      {
         var _loc3_:Array = null;
         var _loc4_:* = null;
         if(param1 && param1.indexOf(",") >= 0)
         {
            _loc4_ = param1;
            param1 = _loc4_.split(",")[0];
         }
         if(_loc4_ != null)
         {
            _loc3_ = getObjectContentURLs(_loc4_,param2,true);
         }
         else
         {
            _loc3_ = getObjectContentURLs(param1,param2,true);
         }
         if(_loc3_.length > 0)
         {
            return _loc3_[0] as String;
         }
         return null;
      }
      
      public function loadThumbnailContent(param1:int, param2:String, param3:String, param4:IEventDispatcher) : Boolean
      {
         var _loc7_:Array = null;
         var _loc9_:int = 0;
         var _loc6_:String = null;
         var _loc5_:* = null;
         var _loc8_:AssetLoaderStruct = null;
         var _loc10_:* = null;
         if(param2 && param2.indexOf(",") >= 0)
         {
            _loc10_ = param2;
            param2 = _loc10_.split(",")[0];
         }
         if(_loc10_ != null)
         {
            _loc7_ = getObjectContentURLs(_loc10_,param3,true);
         }
         else
         {
            _loc7_ = getObjectContentURLs(param2,param3,true);
         }
         if(_loc7_ != null && _loc7_.length > 0)
         {
            _loc9_ = 0;
            while(_loc9_ < _loc7_.length)
            {
               _loc5_ = _loc6_ = _loc7_[_loc9_];
               _loc8_ = UnknownVarFromRoomContentLoader_IAssetLibraryCollection_1.loadAssetFromFile([param2,param3].join("_"),new URLRequest(_loc5_),"image/png",param1);
               _loc8_.addEventListener("AssetLoaderEventComplete",onContentLoaded);
               _loc9_++;
            }
            return true;
         }
         return false;
      }
      
      public function loadObjectContent(param1:String, param2:IEventDispatcher) : Boolean
      {
         var _loc5_:Array = null;
         var _loc7_:int = 0;
         var _loc6_:LibraryLoader = null;
         var _loc4_:String = null;
         var _loc3_:* = null;
         if(param1 == null || param1 == "")
         {
            Logger.log("[RoomContentLoader] Can not load content, object type unknown!");
            return false;
         }
         var _loc9_:* = null;
         if(param1 && param1.indexOf(",") >= 0)
         {
            _loc9_ = param1;
            param1 = _loc9_.split(",")[0];
         }
         if(getAssetLibrary(param1) != null || getAssetLibraryEventDispatcher(param1) != null)
         {
            return false;
         }
         var _loc8_:AssetLibraryCollection = addAssetLibraryCollection(param1,param2) as AssetLibraryCollection;
         if(_loc8_ == null)
         {
            return false;
         }
         if(isIgnoredFurniType(param1))
         {
            Logger.log("Ignored object type found from configuration. Not downloading assets for: " + param1);
            return false;
         }
         if(_loc9_ != null)
         {
            _loc5_ = getObjectContentURLs(_loc9_);
         }
         else
         {
            _loc5_ = getObjectContentURLs(param1);
         }
         if(_loc5_ != null && _loc5_.length > 0)
         {
            _loc8_.addEventListener("AssetLibraryLoaded",onContentLoaded);
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               _loc6_ = new LibraryLoader();
               _loc3_ = _loc4_ = _loc5_[_loc7_];
               _loc8_.loadFromFile(_loc6_,true);
               _loc6_.addEventListener("LIBRARY_LOADER_EVENT_ERROR",onContentLoadError);
               _loc6_.load(new URLRequest(_loc3_));
               _loc7_++;
            }
            return true;
         }
         return false;
      }
      
      private function onContentLoadError(param1:Event) : void
      {
         var _loc3_:Array = null;
         var _loc4_:LibraryLoader = LibraryLoader(param1.target);
         var _loc5_:Array = getPlaceHolderTypes();
         for each(var _loc2_ in _loc5_)
         {
            _loc3_ = getObjectContentURLs(_loc2_);
            if(_loc3_.length > 0 && _loc4_.url != null && _loc4_.url.indexOf(_loc3_[0]) == 0)
            {
               Core.crash("Failed to load asset: " + _loc4_.url,3);
               return;
            }
         }
      }
      
      private function onContentLoaded(param1:Event) : void
      {
         var _loc2_:AssetLoaderStruct = null;
         var _loc3_:IAssetLibraryCollection = null;
         if(disposed)
         {
            return;
         }
         if(param1.target is AssetLoaderStruct)
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            UnknownVarFromRoomContentLoader_IRoomEngine_3_1.iconLoaded(_loc2_.assetLoader.id,_loc2_.assetName,true);
         }
         else
         {
            _loc3_ = param1.target as IAssetLibraryCollection;
            if(_loc3_ == null)
            {
               return;
            }
            processLoadedLibrary(_loc3_);
         }
      }
      
      private function processLoadedLibrary(param1:IAssetLibraryCollection) : void
      {
         var _loc3_:RoomContentLoadedEvent = null;
         var _loc2_:Boolean = false;
         var _loc4_:String = getAssetLibraryType(param1);
         _loc4_ = getRoomObjectOriginalName(_loc4_);
         if(_loc4_ != null)
         {
            _loc2_ = initializeGraphicAssetCollection(_loc4_,param1);
         }
         if(_loc2_)
         {
            if(UnknownVarFromRoomContentLoader_Dictionary_2[_loc4_] != null)
            {
               extractPetDataFromLoadedContent(_loc4_);
            }
            _loc3_ = new RoomContentLoadedEvent("RCLE_SUCCESS",_loc4_);
         }
         else
         {
            _loc3_ = new RoomContentLoadedEvent("RCLE_FAILURE",_loc4_);
         }
         var _loc5_:IEventDispatcher = getAssetLibraryEventDispatcher(_loc4_,true);
         if(_loc5_ != null && _loc3_ != null)
         {
            _loc5_.dispatchEvent(_loc3_);
         }
      }
      
      private function extractPetDataFromLoadedContent(param1:String) : void
      {
         var _loc7_:Map = null;
         var _loc5_:Array = null;
         var _loc9_:Array = null;
         var _loc13_:XML = null;
         var _loc8_:int = 0;
         var _loc16_:int = 0;
         var _loc2_:Array = null;
         var _loc14_:Boolean = false;
         var _loc11_:Map = null;
         var _loc17_:Dictionary = null;
         var _loc10_:String = null;
         var _loc15_:String = null;
         var _loc19_:int = int(UnknownVarFromRoomContentLoader_Dictionary_2[param1]);
         var _loc6_:IGraphicAssetCollection = getGraphicAssetCollection(param1);
         if(_loc6_ != null)
         {
            _loc7_ = new Map();
            _loc5_ = _loc6_.getPaletteNames();
            for each(var _loc12_ in _loc5_)
            {
               _loc9_ = _loc6_.getPaletteColors(_loc12_);
               if(_loc9_ != null && _loc9_.length >= 2)
               {
                  _loc13_ = _loc6_.getPaletteXML(_loc12_);
                  _loc8_ = int(_loc13_.@breed);
                  _loc16_ = int(!!_loc13_.hasOwnProperty("@colortag") ? _loc13_.@colortag : -1);
                  _loc2_ = !!_loc13_.hasOwnProperty("@tags") ? String(_loc13_.@tags).split(",") : [];
                  _loc14_ = !!_loc13_.hasOwnProperty("@master") ? String(_loc13_.@master) == "true" : false;
                  _loc7_.add(_loc12_,new PetColorResult(_loc9_[0],_loc9_[1],_loc8_,_loc16_,_loc12_,_loc14_,_loc2_));
               }
            }
            _petColors.add(_loc19_,_loc7_);
         }
         var _loc4_:XML = getVisualizationXML(param1);
         if(_loc4_ != null)
         {
            _loc11_ = new Map();
            for each(var _loc3_ in _loc4_.visualization)
            {
               _loc17_ = new Dictionary();
               for each(var _loc18_ in _loc3_.layers.layer)
               {
                  if(_loc18_.hasOwnProperty("@tag"))
                  {
                     _loc10_ = _loc18_.@tag;
                     _loc17_[_loc10_] = parseInt(String(_loc18_.@id));
                  }
               }
               _loc15_ = _loc3_.@size;
               _loc11_.add(_loc15_,_loc17_);
            }
            _petLayers.add(_loc19_,_loc11_);
         }
      }
      
      private function initializeGraphicAssetCollection(param1:String, param2:IAssetLibraryCollection) : Boolean
      {
         var _loc4_:XML = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         var _loc3_:Boolean = false;
         var _loc5_:IGraphicAssetCollection = createGraphicAssetCollection(param1,param2);
         if(_loc5_ != null)
         {
            _loc4_ = getAssetXML(param1);
            if(_loc5_.define(_loc4_))
            {
               _loc3_ = true;
            }
            else
            {
               disposeGraphicAssetCollection(param1);
            }
         }
         return _loc3_;
      }
      
      public function extractObjectContent(param1:String, param2:String) : Boolean
      {
         var _loc3_:IAssetLibraryCollection = getAssetLibrary(param1);
         _additionalObjectTypeLibraries.add(param2,param1);
         if(initializeGraphicAssetCollection(param2,_loc3_))
         {
            return true;
         }
         _additionalObjectTypeLibraries.remove(param2);
         return false;
      }
      
      private function getAssetLibraryName(param1:String) : String
      {
         return "RoomContentLoader " + param1;
      }
      
      private function getAssetLibrary(param1:String) : IAssetLibraryCollection
      {
         var _loc3_:String = null;
         var _loc4_:String = getContentType(param1);
         _loc4_ = getRoomObjectOriginalName(_loc4_);
         var _loc2_:IAssetLibraryCollection = _libraries.getValue(getAssetLibraryName(_loc4_)) as IAssetLibraryCollection;
         if(_loc2_ == null)
         {
            _loc3_ = _additionalObjectTypeLibraries.getValue(_loc4_);
            if(_loc3_ != null)
            {
               _loc4_ = getContentType(_loc3_);
               _loc2_ = _libraries.getValue(getAssetLibraryName(_loc4_)) as IAssetLibraryCollection;
            }
         }
         return _loc2_;
      }
      
      private function addAssetLibraryCollection(param1:String, param2:IEventDispatcher) : IAssetLibraryCollection
      {
         var _loc5_:String = getContentType(param1);
         var _loc3_:IAssetLibraryCollection = getAssetLibrary(param1);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         var _loc4_:String = getAssetLibraryName(_loc5_);
         _loc3_ = new AssetLibraryCollection(_loc4_);
         _libraries.add(_loc4_,_loc3_);
         if(param2 != null && getAssetLibraryEventDispatcher(param1) == null)
         {
            UnknownVarFromRoomContentLoader_Map_1.add(_loc5_,param2);
         }
         return _loc3_;
      }
      
      private function getAssetLibraryEventDispatcher(param1:String, param2:Boolean = false) : IEventDispatcher
      {
         var _loc3_:String = getContentType(param1);
         if(!param2)
         {
            return UnknownVarFromRoomContentLoader_Map_1.getValue(_loc3_);
         }
         return UnknownVarFromRoomContentLoader_Map_1.remove(_loc3_);
      }
      
      private function getIconAssetType(param1:AssetLoaderStruct) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:String = param1.assetName;
         var _loc2_:Array = _loc4_.split("_");
         var _loc5_:int = parseInt(_loc2_.pop());
         var _loc3_:String = _loc2_.join("_");
         return _loc5_ > 0 ? _loc3_ + "*" + _loc5_ : _loc3_;
      }
      
      private function getAssetLibraryType(param1:IAssetLibraryCollection) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:ISoundAsset = param1.getAssetByName("index");
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc2_:XML = _loc3_.content as XML;
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.@type;
      }
      
      public function getVisualizationType(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:IAssetLibraryCollection = getAssetLibrary(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc4_:ISoundAsset = _loc2_.getAssetByName(param1 + "_index");
         if(_loc4_ == null)
         {
            _loc4_ = _loc2_.getAssetByName("index");
         }
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc3_:XML = _loc4_.content as XML;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.@visualization;
      }
      
      public function getLogicType(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:IAssetLibraryCollection = getAssetLibrary(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc4_:ISoundAsset = _loc2_.getAssetByName(param1 + "_index");
         if(_loc4_ == null)
         {
            _loc4_ = _loc2_.getAssetByName("index");
         }
         if(_loc4_ == null)
         {
            return null;
         }
         var _loc3_:XML = _loc4_.content as XML;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.@logic;
      }
      
      public function hasVisualizationXML(param1:String) : Boolean
      {
         return hasXML(param1,"_visualization");
      }
      
      public function getVisualizationXML(param1:String) : XML
      {
         return getXML(param1,"_visualization");
      }
      
      public function hasAssetXML(param1:String) : Boolean
      {
         return hasXML(param1,"_assets");
      }
      
      public function getAssetXML(param1:String) : XML
      {
         return getXML(param1,"_assets");
      }
      
      public function hasLogicXML(param1:String) : Boolean
      {
         return hasXML(param1,"_logic");
      }
      
      public function getLogicXML(param1:String) : XML
      {
         return getXML(param1,"_logic");
      }
      
      private function getXML(param1:String, param2:String) : XML
      {
         var _loc3_:IAssetLibraryCollection = getAssetLibrary(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc7_:String = getContentType(param1);
         var _loc5_:String = getRoomObjectAlias(_loc7_);
         var _loc6_:ISoundAsset = _loc3_.getAssetByName(_loc5_ + param2);
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc4_:XML = _loc6_.content as XML;
         if(_loc4_ == null)
         {
            return null;
         }
         return _loc4_;
      }
      
      private function hasXML(param1:String, param2:String) : Boolean
      {
         var _loc3_:IAssetLibraryCollection = getAssetLibrary(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc5_:String = getContentType(param1);
         var _loc4_:String = getRoomObjectAlias(_loc5_);
         return _loc3_.hasAsset(_loc4_ + param2);
      }
      
      public function addGraphicAsset(param1:String, param2:String, param3:BitmapData, param4:Boolean, param5:Boolean = true) : Boolean
      {
         var _loc6_:IGraphicAssetCollection = getGraphicAssetCollection(param1);
         if(_loc6_ != null)
         {
            return _loc6_.addAsset(param2,param3,param4,0,0,false,false);
         }
         return false;
      }
      
      private function createGraphicAssetCollection(param1:String, param2:IAssetLibraryCollection) : IGraphicAssetCollection
      {
         var _loc3_:IGraphicAssetCollection = getGraphicAssetCollection(param1);
         if(_loc3_ != null)
         {
            return _loc3_;
         }
         if(param2 == null)
         {
            return null;
         }
         _loc3_ = _visualizationFactory.createGraphicAssetCollection();
         if(_loc3_ != null)
         {
            _loc3_.assetLibrary = param2;
            UnknownVarFromRoomContentLoader_Map_2.add(param1,_loc3_);
         }
         return _loc3_;
      }
      
      public function getGraphicAssetCollection(param1:String) : IGraphicAssetCollection
      {
         var _loc2_:String = getContentType(param1);
         return UnknownVarFromRoomContentLoader_Map_2.getValue(_loc2_) as IGraphicAssetCollection;
      }
      
      public function roomObjectCreated(param1:IRoomObject, param2:String) : void
      {
         var _loc3_:IRoomObjectController = param1 as IRoomObjectController;
         if(_loc3_ && _loc3_.getModelController())
         {
            _loc3_.getModelController().setString("object_room_id",param2,true);
         }
      }
      
      private function disposeGraphicAssetCollection(param1:String) : Boolean
      {
         var _loc3_:IGraphicAssetCollection = null;
         var _loc2_:String = getContentType(param1);
         if(UnknownVarFromRoomContentLoader_Map_2[_loc2_] != null)
         {
            _loc3_ = UnknownVarFromRoomContentLoader_Map_2.remove(_loc2_);
            if(_loc3_ != null)
            {
               _loc3_.dispose();
            }
            return true;
         }
         return false;
      }
      
      public function furniDataReady() : void
      {
         initFurnitureData();
      }
      
      public function setActiveObjectType(param1:int, param2:String) : void
      {
         _activeObjectTypes.remove(param1);
         _activeObjectTypes.add(param1,param2);
      }
      
      public function compressAssets() : void
      {
         var _loc5_:IGraphicAssetCollection = null;
         var _loc10_:String = null;
         var _loc7_:int = 0;
         var _loc2_:String = null;
         var _loc3_:IAssetLibraryCollection = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:BitmapDataAsset = null;
         var _loc1_:int = int(UnknownVarFromRoomContentLoader_Map_2.length);
         var _loc6_:Array = getPlaceHolderTypes();
         _loc7_ = _loc1_ - 1;
         while(_loc7_ > -1)
         {
            _loc10_ = UnknownVarFromRoomContentLoader_Map_2.getKey(_loc7_);
            if(_loc6_.indexOf(_loc10_) == -1)
            {
               _loc5_ = UnknownVarFromRoomContentLoader_Map_2.getValue(_loc10_);
               _loc2_ = getAssetLibraryName(_loc10_);
               _loc3_ = _libraries.getValue(_loc2_) as IAssetLibraryCollection;
               if(_loc3_)
               {
                  _loc4_ = int(_loc3_.numAssets);
                  _loc8_ = 0;
                  while(_loc8_ < _loc4_)
                  {
                     _loc9_ = _loc3_.getAssetByIndex(_loc8_) as BitmapDataAsset;
                     if(!_loc9_)
                     {
                     }
                     _loc8_++;
                  }
               }
            }
            _loc7_--;
         }
         _lastAssetCompressionTime = getTimer();
      }
      
      public function purge() : void
      {
         var _loc4_:IGraphicAssetCollection = null;
         var _loc7_:String = null;
         var _loc5_:int = 0;
         var _loc2_:String = null;
         var _loc3_:IAssetLibraryCollection = null;
         if(_disposed)
         {
            return;
         }
         var _loc1_:int = int(UnknownVarFromRoomContentLoader_Map_2.length);
         var _loc6_:int = getTimer();
         _loc5_ = _loc1_ - 1;
         while(_loc5_ > -1)
         {
            _loc7_ = UnknownVarFromRoomContentLoader_Map_2.getKey(_loc5_);
            if(PLACE_HOLDER_TYPES.indexOf(_loc7_) < 0)
            {
               _loc4_ = UnknownVarFromRoomContentLoader_Map_2.getValue(_loc7_);
               if(_loc4_ && _loc4_.getReferenceCount() < 1 && _loc6_ - _loc4_.getLastReferenceTimeStamp() >= 20000)
               {
                  UnknownVarFromRoomContentLoader_Map_2.remove(_loc7_);
                  _loc4_.dispose();
                  _loc2_ = getAssetLibraryName(_loc7_);
                  _loc3_ = _libraries.getValue(_loc2_) as IAssetLibraryCollection;
                  if(_loc3_)
                  {
                     _libraries.remove(_loc2_);
                     _loc3_.dispose();
                  }
               }
            }
            _loc5_--;
         }
      }
      
      public function set iconAssets(param1:IAssetLibraryCollection) : void
      {
         UnknownVarFromRoomContentLoader_IAssetLibraryCollection_1 = param1;
      }
      
      public function set iconListener(param1:IRoomEngine_3) : void
      {
         UnknownVarFromRoomContentLoader_IRoomEngine_3_1 = param1;
      }
   }
}

