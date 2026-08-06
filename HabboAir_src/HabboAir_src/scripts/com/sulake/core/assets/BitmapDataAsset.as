package com.sulake.core.assets
{
   import com.sulake.core.utils.images.PNGDecoder;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class BitmapDataAsset implements ILazyAsset
   {
      protected static var _instances:uint = 0;
      
      protected static var _allocatedByteCount:uint = 0;
      
      private static const CLONE_BITMAP_DATA:Boolean = true;
      
      private static const USE_ASYNC_LOADER:Boolean = false;
      
      private static const IMMEDIATE_PREPARE:Boolean = false;
      
      public var name:String;
      
      private var _disposed:Boolean = false;
      
      private var _rectangle:Rectangle;
      
      private var UnknownVarFromBitmapDataAsset_Object_1:Object;
      
      private var _bitmap:BitmapData;
      
      private var _offset:Point = new Point(0,0);
      
      private var _flipH:Boolean = false;
      
      private var _flipV:Boolean = false;
      
      private var _decl:AssetTypeDeclaration;
      
      private var _url:String;
      
      private var UnknownVarFromBitmapDataAsset_Loader_1:Loader;
      
      private var UnknownVarFromBitmapDataAsset_Boolean_1:Boolean = true;
      
      public function BitmapDataAsset(param1:AssetTypeDeclaration, param2:String = null)
      {
         super();
         _decl = param1;
         _url = param2;
         _instances++;
      }
      
      public static function get instances() : uint
      {
         return _instances;
      }
      
      public static function get allocatedByteCount() : uint
      {
         return _allocatedByteCount;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function get flipH() : Boolean
      {
         return _flipH;
      }
      
      public function get flipV() : Boolean
      {
         return _flipV;
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
      
      public function get content() : Object
      {
         if(!_bitmap)
         {
            prepareLazyContent();
         }
         return _bitmap;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get rectangle() : Rectangle
      {
         var _loc1_:BitmapData = null;
         if(!_rectangle)
         {
            _loc1_ = BitmapData(content);
            if(_loc1_)
            {
               _rectangle = _loc1_.rect;
            }
         }
         return _rectangle;
      }
      
      public function get declaration() : AssetTypeDeclaration
      {
         return _decl;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _instances--;
            if(_bitmap)
            {
               try
               {
                  _allocatedByteCount -= _bitmap.width * _bitmap.height * 4;
                  if(UnknownVarFromBitmapDataAsset_Boolean_1)
                  {
                     _bitmap.dispose();
                  }
               }
               catch(e:Error)
               {
               }
            }
            if(UnknownVarFromBitmapDataAsset_Object_1 is BitmapData)
            {
               if(UnknownVarFromBitmapDataAsset_Boolean_1)
               {
                  (UnknownVarFromBitmapDataAsset_Object_1 as BitmapData).dispose();
               }
            }
            else if(UnknownVarFromBitmapDataAsset_Object_1 is Bitmap)
            {
               (UnknownVarFromBitmapDataAsset_Object_1 as Bitmap).bitmapData.dispose();
            }
            else if(UnknownVarFromBitmapDataAsset_Object_1 is ByteArray)
            {
               (UnknownVarFromBitmapDataAsset_Object_1 as ByteArray).clear();
            }
            UnknownVarFromBitmapDataAsset_Object_1 = null;
            _bitmap = null;
            _offset = null;
            _decl = null;
            _url = null;
            _rectangle = null;
            _disposed = true;
         }
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         if(param1 == null)
         {
         }
         if(_bitmap)
         {
            if(_bitmap == param1 as BitmapData)
            {
               return;
            }
            if(UnknownVarFromBitmapDataAsset_Boolean_1)
            {
               _bitmap.dispose();
            }
         }
         UnknownVarFromBitmapDataAsset_Object_1 = param1;
         _bitmap = null;
      }
      
      public function prepareLazyContent() : void
      {
         var _loc3_:Object = null;
         var _loc2_:Bitmap = null;
         var _loc1_:Bitmap = null;
         if(UnknownVarFromBitmapDataAsset_Object_1 == null)
         {
            return;
         }
         if(UnknownVarFromBitmapDataAsset_Object_1 is Class)
         {
            _loc3_ = new (UnknownVarFromBitmapDataAsset_Object_1 as Class)();
            _loc2_ = _loc3_ as Bitmap;
            if(_loc2_ != null)
            {
               _bitmap = _loc2_.bitmapData.clone();
               _loc2_.bitmapData.dispose();
               if(_bitmap != null)
               {
                  _allocatedByteCount += _bitmap.width * _bitmap.height * 4;
                  UnknownVarFromBitmapDataAsset_Object_1 = null;
                  return;
               }
               _loc3_ = new BitmapData(20,20,true,16711680);
            }
            _bitmap = _loc3_ as BitmapData;
            if(_bitmap != null)
            {
               UnknownVarFromBitmapDataAsset_Object_1 = null;
               return;
            }
         }
         if(UnknownVarFromBitmapDataAsset_Object_1 is Bitmap)
         {
            _loc1_ = Bitmap(UnknownVarFromBitmapDataAsset_Object_1);
            _bitmap = _loc1_.bitmapData;
            if(_bitmap == null)
            {
               throw new Error("Failed to convert Bitmap to BitmapDataAsset!");
            }
            UnknownVarFromBitmapDataAsset_Object_1 = null;
         }
         if(UnknownVarFromBitmapDataAsset_Object_1 is BitmapData)
         {
            _bitmap = UnknownVarFromBitmapDataAsset_Object_1 as BitmapData;
            if(_bitmap != null)
            {
               UnknownVarFromBitmapDataAsset_Object_1 = null;
               return;
            }
            throw new Error("Failed to convert BitmapData to BitmapDataAsset!");
         }
         if(UnknownVarFromBitmapDataAsset_Object_1 is BitmapDataAsset)
         {
            _bitmap = BitmapDataAsset(UnknownVarFromBitmapDataAsset_Object_1)._bitmap;
            _offset = BitmapDataAsset(UnknownVarFromBitmapDataAsset_Object_1)._offset;
            _flipH = BitmapDataAsset(UnknownVarFromBitmapDataAsset_Object_1)._flipH;
            _flipV = BitmapDataAsset(UnknownVarFromBitmapDataAsset_Object_1)._flipV;
            if(_bitmap != null)
            {
               UnknownVarFromBitmapDataAsset_Object_1 = null;
               return;
            }
            throw new Error("Failed to read content from BitmapDataAsset!");
         }
         if(UnknownVarFromBitmapDataAsset_Object_1 is ByteArray)
         {
            try
            {
               _bitmap = new PNGDecoder().decode(UnknownVarFromBitmapDataAsset_Object_1 as ByteArray);
            }
            catch(e:Error)
            {
               Logger.log("Error decoding asset content to PNG: " + url + "::" + name);
            }
            UnknownVarFromBitmapDataAsset_Object_1 = null;
         }
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var _loc2_:Loader = param1.currentTarget.loader as Loader;
         var _loc3_:Bitmap = _loc2_.content as Bitmap;
         _bitmap = _loc3_.bitmapData;
         if(UnknownVarFromBitmapDataAsset_Loader_1 && UnknownVarFromBitmapDataAsset_Loader_1.contentLoaderInfo)
         {
            UnknownVarFromBitmapDataAsset_Loader_1.contentLoaderInfo.removeEventListener("complete",onLoaderComplete);
         }
         UnknownVarFromBitmapDataAsset_Loader_1 = null;
      }
      
      public function setFromOtherAsset(param1:ISoundAsset) : void
      {
         if(param1 is BitmapDataAsset)
         {
            _bitmap = BitmapDataAsset(param1)._bitmap;
            _offset = BitmapDataAsset(param1)._offset;
            return;
         }
         throw new Error("Provided asset should be of type BitmapDataAsset!");
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
         var _loc3_:Array = null;
         var _loc5_:String = null;
         for each(var _loc2_ in param1)
         {
            _loc5_ = _loc2_.attribute("key");
            var _loc4_:String = _loc2_.attribute("value");
            switch(_loc5_)
            {
               case "offset":
                  _loc3_ = _loc4_.split(",");
                  _offset.x = parseInt(_loc3_[0]);
                  _offset.y = parseInt(_loc3_[1]);
                  break;
               case "region":
                  _loc3_ = _loc4_.split(",");
                  if(!_rectangle)
                  {
                     _rectangle = new Rectangle();
                  }
                  _rectangle.x = parseInt(_loc3_[0]);
                  _rectangle.y = parseInt(_loc3_[1]);
                  _rectangle.width = parseInt(_loc3_[2]);
                  _rectangle.height = parseInt(_loc3_[3]);
                  break;
               case "flipH":
                  _flipH = _loc4_ == "1" || _loc4_ == "true";
                  break;
               case "flipV":
                  _flipV = _loc4_ == "1" || _loc4_ == "true";
                  break;
            }
         }
      }
   }
}

