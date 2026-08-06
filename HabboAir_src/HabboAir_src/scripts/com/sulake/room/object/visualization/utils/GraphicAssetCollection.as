package com.sulake.room.object.visualization.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAssetLibraryCollection;
   import com.sulake.core.assets.ISoundAsset;
   import com.sulake.core.utils.Map;
   import com.sulake.room.utils.UnknownRoomUtils1;
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class GraphicAssetCollection implements IGraphicAssetCollection
   {
      private static const PALETTE_ASSET_DISPOSE_THRESHOLD:int = 10;
      
      private static const USE_LAZY_ASSETS:Boolean = false;
      
      private static const PALETTE_ATTRIBUTES:Array = ["id","source"];
      
      private var _assets:Map;
      
      private var _assetLibrary:IAssetLibraryCollection;
      
      private var _palettes:Map;
      
      private var _paletteAssetNames:Array;
      
      private var UnknownVarFromGraphicAssetCollection_Map_1:Map;
      
      private var _referenceCount:int = 0;
      
      private var _lastReferenceTimeStamp:int = 0;
      
      private var UnknownVarFromGraphicAssetCollection_Dictionary_1:Dictionary;
      
      public function GraphicAssetCollection()
      {
         super();
         _assets = new Map();
         _palettes = new Map();
         UnknownVarFromGraphicAssetCollection_Map_1 = new Map();
         _paletteAssetNames = [];
         UnknownVarFromGraphicAssetCollection_Dictionary_1 = new Dictionary();
      }
      
      public function dispose() : void
      {
         var _loc1_:GraphicAssetPalette = null;
         var _loc2_:String = null;
         var _loc3_:GraphicAsset = null;
         if(_palettes != null)
         {
            for(_loc2_ in _palettes)
            {
               _loc1_ = _palettes[_loc2_];
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
            }
            _palettes.reset();
         }
         if(UnknownVarFromGraphicAssetCollection_Map_1 != null)
         {
            _palettes.reset();
         }
         if(_paletteAssetNames != null)
         {
            disposePaletteAssets();
            _paletteAssetNames = null;
         }
         if(_assets != null)
         {
            for(_loc2_ in _assets)
            {
               _loc3_ = _assets[_loc2_];
               if(_loc3_ != null)
               {
                  _loc3_.recycle();
               }
            }
            _assets.reset();
         }
         if(UnknownVarFromGraphicAssetCollection_Dictionary_1)
         {
            for(var _loc4_ in UnknownVarFromGraphicAssetCollection_Dictionary_1)
            {
               delete UnknownVarFromGraphicAssetCollection_Dictionary_1[_loc4_];
            }
         }
         _assetLibrary = null;
      }
      
      public function set assetLibrary(param1:IAssetLibraryCollection) : void
      {
         _assetLibrary = param1;
      }
      
      public function addReference() : void
      {
         _referenceCount++;
         _lastReferenceTimeStamp = getTimer();
      }
      
      public function removeReference() : void
      {
         _referenceCount--;
         if(_referenceCount <= 0)
         {
            _referenceCount = 0;
            _lastReferenceTimeStamp = getTimer();
            disposePaletteAssets(false);
         }
      }
      
      public function getReferenceCount() : int
      {
         return _referenceCount;
      }
      
      public function getLastReferenceTimeStamp() : int
      {
         return _lastReferenceTimeStamp;
      }
      
      public function define(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:XMLList = param1.asset;
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:XMLList = param1.palette;
         if(_loc2_ != null)
         {
            definePalettes(_loc2_);
         }
         defineAssets(_loc3_);
         return true;
      }
      
      private function defineAssetsLazy(param1:XMLList) : void
      {
         var _loc3_:String = null;
         var _loc2_:* = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = _loc2_.@name;
            if(_loc3_.length > 0)
            {
               UnknownVarFromGraphicAssetCollection_Dictionary_1[_loc3_] = _loc2_;
            }
         }
      }
      
      private function defineAssets(param1:XMLList) : void
      {
         var _loc3_:int = 0;
         var _loc2_:XML = null;
         var _loc10_:String = null;
         var _loc4_:* = null;
         var _loc5_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc6_:* = false;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc13_:ISoundAsset = null;
         var _loc8_:Boolean = false;
         var _loc12_:IGraphicAsset = null;
         var _loc14_:int = int(param1.length());
         _loc3_ = 0;
         while(_loc3_ < _loc14_)
         {
            _loc2_ = param1[_loc3_];
            _loc10_ = _loc2_.@name;
            if(_loc10_.length > 0)
            {
               _loc4_ = null;
               _loc5_ = false;
               _loc11_ = false;
               _loc6_ = false;
               _loc7_ = 0;
               _loc9_ = 0;
               _loc7_ = -int(_loc2_.@x);
               _loc9_ = -int(_loc2_.@y);
               _loc4_ = _loc2_.@source;
               if(int(_loc2_.@flipH) > 0)
               {
                  if(_loc4_.length > 0)
                  {
                     _loc5_ = true;
                  }
               }
               if(int(_loc2_.@flipV) > 0)
               {
                  if(_loc4_.length > 0)
                  {
                     _loc11_ = true;
                  }
               }
               _loc6_ = int(_loc2_.@usesPalette) != 0;
               if(_loc4_.length == 0)
               {
                  _loc4_ = _loc10_;
               }
               _loc13_ = _assetLibrary.getAssetByName(_loc4_);
               if(_loc13_ != null)
               {
                  _loc8_ = createAsset(_loc10_,_loc4_,_loc13_,_loc5_,_loc11_,_loc7_,_loc9_,_loc6_);
                  if(!_loc8_)
                  {
                     _loc12_ = getAsset(_loc10_);
                     if(_loc12_ != null && _loc12_.assetName != _loc12_.libraryAssetName)
                     {
                        _loc8_ = replaceAsset(_loc10_,_loc4_,_loc13_,_loc5_,_loc11_,_loc7_,_loc9_,_loc6_);
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
      
      private function definePalettes(param1:XMLList) : void
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:ISoundAsset = null;
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:String = null;
         var _loc4_:GraphicAssetPalette = null;
         for each(var _loc5_ in param1)
         {
            if(UnknownRoomUtils1.checkRequiredAttributes(_loc5_,PALETTE_ATTRIBUTES))
            {
               _loc6_ = _loc5_.@id;
               _loc7_ = _loc5_.@source;
               if(_palettes[_loc6_] == null)
               {
                  _loc8_ = _assetLibrary.getAssetByName(_loc7_);
                  if(_loc8_.content == null)
                  {
                     Logger.log("Palette asset was null: " + _loc7_);
                  }
                  else
                  {
                     if(_loc8_.content is Class)
                     {
                        _loc2_ = new (_loc8_.content as Class)() as ByteArray;
                     }
                     else
                     {
                        _loc2_ = _loc8_.content as ByteArray;
                     }
                     _loc3_ = 16777215;
                     _loc9_ = 16777215;
                     _loc10_ = _loc5_.@color1;
                     if(_loc10_.length > 0)
                     {
                        _loc3_ = parseInt(_loc10_,16);
                        _loc9_ = _loc3_;
                     }
                     _loc10_ = _loc5_.@color2;
                     if(_loc10_.length > 0)
                     {
                        _loc9_ = parseInt(_loc10_,16);
                     }
                     _loc4_ = new GraphicAssetPalette(_loc2_,_loc3_,_loc9_);
                     _palettes[_loc6_] = _loc4_;
                     UnknownVarFromGraphicAssetCollection_Map_1[_loc6_] = _loc5_;
                  }
               }
            }
         }
      }
      
      protected function createAsset(param1:String, param2:String, param3:ISoundAsset, param4:Boolean, param5:Boolean, param6:Number, param7:Number, param8:Boolean) : Boolean
      {
         if(_assets[param1] != null)
         {
            return false;
         }
         if(UnknownVarFromGraphicAssetCollection_Dictionary_1[param1])
         {
            return false;
         }
         var _loc9_:GraphicAsset = GraphicAsset.allocate(param1,param2,param3,param4,param5,param6,param7,param8);
         _assets[param1] = _loc9_;
         return true;
      }
      
      protected function replaceAsset(param1:String, param2:String, param3:ISoundAsset, param4:Boolean, param5:Boolean, param6:Number, param7:Number, param8:Boolean) : Boolean
      {
         var _loc9_:GraphicAsset = _assets.remove(param1);
         if(_loc9_ != null)
         {
            _loc9_.recycle();
         }
         else
         {
            delete UnknownVarFromGraphicAssetCollection_Dictionary_1[param1];
         }
         return createAsset(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function getAsset(param1:String) : IGraphicAsset
      {
         var _loc7_:* = null;
         var _loc8_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc9_:* = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc11_:ISoundAsset = null;
         var _loc10_:IGraphicAsset = null;
         var _loc2_:IGraphicAsset = _assets.getValue(param1);
         if(_loc2_)
         {
            return _loc2_;
         }
         var _loc5_:XML = UnknownVarFromGraphicAssetCollection_Dictionary_1[param1];
         if(_loc5_)
         {
            delete UnknownVarFromGraphicAssetCollection_Dictionary_1[param1];
            _loc7_ = null;
            _loc8_ = false;
            _loc6_ = false;
            _loc9_ = false;
            _loc3_ = 0;
            _loc4_ = 0;
            _loc3_ = -int(_loc5_.@x);
            _loc4_ = -int(_loc5_.@y);
            _loc7_ = _loc5_.@source;
            if(int(_loc5_.@flipH) > 0)
            {
               if(_loc7_.length > 0)
               {
                  _loc8_ = true;
               }
            }
            if(int(_loc5_.@flipV) > 0)
            {
               if(_loc7_.length > 0)
               {
                  _loc6_ = true;
               }
            }
            _loc9_ = int(_loc5_.@usesPalette) != 0;
            if(_loc7_.length == 0)
            {
               _loc7_ = param1;
            }
            _loc11_ = _assetLibrary.getAssetByName(_loc7_);
            if(_loc11_ != null)
            {
               if(createAsset(param1,_loc7_,_loc11_,_loc8_,_loc6_,_loc3_,_loc4_,_loc9_))
               {
                  return _assets[param1];
               }
               _loc10_ = getAsset(param1);
               if(_loc10_ != null && _loc10_.assetName != _loc10_.libraryAssetName)
               {
                  if(!replaceAsset(param1,_loc7_,_loc11_,_loc8_,_loc6_,_loc3_,_loc4_,_loc9_))
                  {
                     return null;
                  }
               }
            }
         }
         return null;
      }
      
      public function getAssetWithPalette(param1:String, param2:String) : IGraphicAsset
      {
         var _loc3_:IGraphicAsset = null;
         var _loc6_:String = null;
         var _loc4_:BitmapDataAsset = null;
         var _loc10_:BitmapData = null;
         var _loc7_:GraphicAssetPalette = null;
         var _loc5_:BitmapData = null;
         var _loc8_:String = param1 + "@" + param2;
         var _loc9_:IGraphicAsset = getAsset(_loc8_);
         if(_loc9_ == null)
         {
            _loc3_ = getAsset(param1);
            if(_loc3_ == null || !_loc3_.usesPalette)
            {
               return _loc3_;
            }
            _loc6_ = _loc3_.libraryAssetName + "@" + param2;
            _loc4_ = getLibraryAsset(_loc6_);
            if(_loc4_ == null)
            {
               _loc10_ = _loc3_.asset.content as BitmapData;
               if(_loc10_ != null)
               {
                  _loc7_ = getPalette(param2);
                  if(_loc7_ == null)
                  {
                     return _loc3_;
                  }
                  _loc5_ = _loc10_.clone();
                  _loc7_.colorizeBitmap(_loc5_);
                  _loc4_ = addLibraryAsset(_loc6_,_loc5_);
                  if(_loc4_ == null)
                  {
                     _loc5_.dispose();
                     return null;
                  }
               }
            }
            _paletteAssetNames.push(_loc8_);
            createAsset(_loc8_,_loc6_,_loc4_,_loc3_.flipH,_loc3_.flipV,_loc3_.originalOffsetX,_loc3_.originalOffsetY,false);
            _loc9_ = getAsset(_loc8_);
         }
         return _loc9_;
      }
      
      public function getPaletteNames() : Array
      {
         return _palettes.getKeys();
      }
      
      public function getPaletteColors(param1:String) : Array
      {
         var _loc2_:GraphicAssetPalette = getPalette(param1);
         if(_loc2_ != null)
         {
            return [_loc2_.primaryColor,_loc2_.secondaryColor];
         }
         return null;
      }
      
      public function getPaletteXML(param1:String) : XML
      {
         return UnknownVarFromGraphicAssetCollection_Map_1[param1];
      }
      
      private function getPalette(param1:String) : GraphicAssetPalette
      {
         return _palettes[param1];
      }
      
      public function addAsset(param1:String, param2:BitmapData, param3:Boolean, param4:int = 0, param5:int = 0, param6:Boolean = false, param7:Boolean = false) : Boolean
      {
         var _loc9_:BitmapData = null;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(_assetLibrary == null)
         {
            return false;
         }
         var _loc8_:BitmapDataAsset = getLibraryAsset(param1);
         if(_loc8_ == null)
         {
            _loc8_ = new BitmapDataAsset(_assetLibrary.getAssetTypeDeclarationByClass(BitmapDataAsset));
            _assetLibrary.setAsset(param1,_loc8_);
            _loc8_.setUnknownContent(param2);
            return createAsset(param1,param1,_loc8_,param6,param7,param4,param5,false);
         }
         if(param3)
         {
            _loc9_ = _loc8_.content as BitmapData;
            if(_loc9_ != null && _loc9_ != param2)
            {
               _loc9_.dispose();
            }
            _loc8_.setUnknownContent(param2);
            return true;
         }
         return false;
      }
      
      public function disposeAsset(param1:String) : void
      {
         var _loc3_:BitmapDataAsset = null;
         var _loc2_:GraphicAsset = _assets.remove(param1);
         if(_loc2_ != null)
         {
            _loc3_ = getLibraryAsset(_loc2_.libraryAssetName);
            if(_loc3_ != null)
            {
               _assetLibrary.removeAsset(_loc3_);
               _loc3_.dispose();
            }
            _loc2_.recycle();
         }
         else
         {
            delete UnknownVarFromGraphicAssetCollection_Dictionary_1[param1];
         }
      }
      
      private function getLibraryAsset(param1:String) : BitmapDataAsset
      {
         return _assetLibrary.getAssetByName(param1) as BitmapDataAsset;
      }
      
      private function addLibraryAsset(param1:String, param2:BitmapData) : BitmapDataAsset
      {
         var _loc3_:BitmapDataAsset = getLibraryAsset(param1);
         if(_loc3_ == null)
         {
            _loc3_ = new BitmapDataAsset(_assetLibrary.getAssetTypeDeclarationByClass(BitmapDataAsset));
            _assetLibrary.setAsset(param1,_loc3_);
            _loc3_.setUnknownContent(param2);
            return _loc3_;
         }
         return null;
      }
      
      private function disposePaletteAssets(param1:Boolean = true) : void
      {
         if(_paletteAssetNames != null)
         {
            if(param1 || _paletteAssetNames.length > 10)
            {
               for each(var _loc2_ in _paletteAssetNames)
               {
                  disposeAsset(_loc2_);
               }
               _paletteAssetNames = [];
            }
         }
      }
      
      public function get assetLibrary() : IAssetLibraryCollection
      {
         return _assetLibrary;
      }
   }
}

