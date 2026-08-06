package deng.fzip
{
   import deng.utils.ChecksumUtil;
   import flash.utils.*;
   
   public class FZipFile
   {
      public static const COMPRESSION_NONE:int = 0;
      
      public static const COMPRESSION_SHRUNK:int = 1;
      
      public static const COMPRESSION_REDUCED_1:int = 2;
      
      public static const COMPRESSION_REDUCED_2:int = 3;
      
      public static const COMPRESSION_REDUCED_3:int = 4;
      
      public static const COMPRESSION_REDUCED_4:int = 5;
      
      public static const COMPRESSION_IMPLODED:int = 6;
      
      public static const COMPRESSION_TOKENIZED:int = 7;
      
      public static const COMPRESSION_DEFLATED:int = 8;
      
      public static const COMPRESSION_DEFLATED_EXT:int = 9;
      
      public static const COMPRESSION_IMPLODED_PKWARE:int = 10;
      
      protected static var HAS_UNCOMPRESS:Boolean = describeType(ByteArray).factory.method.(@name == "uncompress").parameter.length() > 0;
      
      protected static var UnknownVarFromFZipFile_Boolean_1:Boolean = describeType(ByteArray).factory.method.(@name == "inflate").length() > 0;
      
      protected var UnknownVarFromFZipFile_Int_1:int = 0;
      
      protected var _versionNumber:String = "2.0";
      
      protected var UnknownVarFromFZipFile_Int_2:int = 8;
      
      protected var UnknownVarFromFZipFile_Boolean_2:Boolean = false;
      
      protected var UnknownVarFromFZipFile_Int_3:int = -1;
      
      protected var _implodeShannonFanoTrees:int = -1;
      
      protected var UnknownVarFromFZipFile_Int_4:int = -1;
      
      protected var _hasDataDescriptor:Boolean = false;
      
      protected var UnknownVarFromFZipFile_Boolean_3:Boolean = false;
      
      protected var _date:Date;
      
      protected var _adler32:uint;
      
      protected var _hasAdler32:Boolean = false;
      
      protected var _sizeFilename:uint = 0;
      
      protected var UnknownVarFromFZipFile_Uint_1:uint = 0;
      
      protected var _filename:String = "";
      
      protected var UnknownVarFromFZipFile_String_1:String;
      
      protected var UnknownVarFromFZipFile_Dictionary_1:Dictionary;
      
      protected var UnknownVarFromFZipFile_String_2:String = "";
      
      protected var _content:ByteArray;
      
      internal var _crc32:uint;
      
      internal var _sizeCompressed:uint = 0;
      
      internal var _sizeUncompressed:uint = 0;
      
      protected var isCompressed:Boolean = false;
      
      protected var UnknownVarFromFZipFile_Function_1:Function;
      
      public function FZipFile(param1:String = "utf-8")
      {
         UnknownVarFromFZipFile_Function_1 = parseFileHead;
         super();
         UnknownVarFromFZipFile_String_1 = param1;
         UnknownVarFromFZipFile_Dictionary_1 = new Dictionary();
         _content = new ByteArray();
         _content.endian = "bigEndian";
      }
      
      public function get date() : Date
      {
         return _date;
      }
      
      public function set date(param1:Date) : void
      {
         _date = param1 ?? new Date();
      }
      
      public function get filename() : String
      {
         return _filename;
      }
      
      public function set filename(param1:String) : void
      {
         _filename = param1;
      }
      
      internal function get hasDataDescriptor() : Boolean
      {
         return _hasDataDescriptor;
      }
      
      public function get content() : ByteArray
      {
         if(isCompressed)
         {
            uncompress();
         }
         return _content;
      }
      
      public function set content(param1:ByteArray) : void
      {
         setContent(param1);
      }
      
      public function setContent(param1:ByteArray, param2:Boolean = true) : void
      {
         if(param1 != null && param1.length > 0)
         {
            param1.position = 0;
            param1.readBytes(_content,0,param1.length);
            _crc32 = ChecksumUtil.CRC32(_content);
            _hasAdler32 = false;
         }
         else
         {
            _content.length = 0;
            _content.position = 0;
            isCompressed = false;
         }
         if(param2)
         {
            compress();
         }
         else
         {
            _sizeUncompressed = _sizeCompressed = _content.length;
         }
      }
      
      public function get versionNumber() : String
      {
         return _versionNumber;
      }
      
      public function get sizeCompressed() : uint
      {
         return _sizeCompressed;
      }
      
      public function get sizeUncompressed() : uint
      {
         return _sizeUncompressed;
      }
      
      public function getContentAsString(param1:Boolean = true, param2:String = "utf-8") : String
      {
         var _loc3_:String = null;
         if(isCompressed)
         {
            uncompress();
         }
         _content.position = 0;
         if(param2 == "utf-8")
         {
            _loc3_ = _content.readUTFBytes(_content.bytesAvailable);
         }
         else
         {
            _loc3_ = _content.readMultiByte(_content.bytesAvailable,param2);
         }
         _content.position = 0;
         if(param1)
         {
            compress();
         }
         return _loc3_;
      }
      
      public function setContentAsString(param1:String, param2:String = "utf-8", param3:Boolean = true) : void
      {
         _content.length = 0;
         _content.position = 0;
         isCompressed = false;
         if(param1 != null && param1.length > 0)
         {
            if(param2 == "utf-8")
            {
               _content.writeUTFBytes(param1);
            }
            else
            {
               _content.writeMultiByte(param1,param2);
            }
            _crc32 = ChecksumUtil.CRC32(_content);
            _hasAdler32 = false;
         }
         if(param3)
         {
            compress();
         }
         else
         {
            _sizeUncompressed = _sizeCompressed = _content.length;
         }
      }
      
      public function serialize(param1:IDataOutput, param2:Boolean, param3:Boolean = false, param4:uint = 0) : uint
      {
         var _loc7_:ByteArray = null;
         var _loc14_:Boolean = false;
         if(param1 == null)
         {
            return 0;
         }
         if(param3)
         {
            param1.writeUnsignedInt(33639248);
            param1.writeShort(UnknownVarFromFZipFile_Int_1 << 8 | 0x14);
         }
         else
         {
            param1.writeUnsignedInt(67324752);
         }
         param1.writeShort(UnknownVarFromFZipFile_Int_1 << 8 | 0x14);
         param1.writeShort(UnknownVarFromFZipFile_String_1 == "utf-8" ? 2048 : 0);
         param1.writeShort(isCompressed ? 8 : 0);
         var _loc6_:Date = _date ?? new Date();
         var _loc11_:uint = uint(uint(_loc6_.getSeconds()) | uint(_loc6_.getMinutes()) << 5 | uint(_loc6_.getHours()) << 11);
         var _loc8_:uint = uint(uint(_loc6_.getDate()) | uint(_loc6_.getMonth() + 1) << 5 | uint(_loc6_.getFullYear() - 1980) << 9);
         param1.writeShort(_loc11_);
         param1.writeShort(_loc8_);
         param1.writeUnsignedInt(_crc32);
         param1.writeUnsignedInt(_sizeCompressed);
         param1.writeUnsignedInt(_sizeUncompressed);
         var _loc16_:ByteArray = new ByteArray();
         _loc16_.endian = "littleEndian";
         if(UnknownVarFromFZipFile_String_1 == "utf-8")
         {
            _loc16_.writeUTFBytes(_filename);
         }
         else
         {
            _loc16_.writeMultiByte(_filename,UnknownVarFromFZipFile_String_1);
         }
         var _loc9_:uint = _loc16_.position;
         for(var _loc10_ in UnknownVarFromFZipFile_Dictionary_1)
         {
            _loc7_ = UnknownVarFromFZipFile_Dictionary_1[_loc10_] as ByteArray;
            if(_loc7_ != null)
            {
               _loc16_.writeShort(uint(_loc10_));
               _loc16_.writeShort(_loc7_.length);
               _loc16_.writeBytes(_loc7_);
            }
         }
         if(param2)
         {
            if(!_hasAdler32)
            {
               _loc14_ = isCompressed;
               if(_loc14_)
               {
                  uncompress();
               }
               _adler32 = ChecksumUtil.Adler32(_content,0,_content.length);
               _hasAdler32 = true;
               if(_loc14_)
               {
                  compress();
               }
            }
            _loc16_.writeShort(56026);
            _loc16_.writeShort(4);
            _loc16_.writeUnsignedInt(_adler32);
         }
         var _loc15_:uint = uint(_loc16_.position - _loc9_);
         if(param3 && UnknownVarFromFZipFile_String_2.length > 0)
         {
            if(UnknownVarFromFZipFile_String_1 == "utf-8")
            {
               _loc16_.writeUTFBytes(UnknownVarFromFZipFile_String_2);
            }
            else
            {
               _loc16_.writeMultiByte(UnknownVarFromFZipFile_String_2,UnknownVarFromFZipFile_String_1);
            }
         }
         var _loc5_:uint = uint(_loc16_.position - _loc9_ - _loc15_);
         param1.writeShort(_loc9_);
         param1.writeShort(_loc15_);
         if(param3)
         {
            param1.writeShort(_loc5_);
            param1.writeShort(0);
            param1.writeShort(0);
            param1.writeUnsignedInt(0);
            param1.writeUnsignedInt(param4);
         }
         if(_loc9_ + _loc15_ + _loc5_ > 0)
         {
            param1.writeBytes(_loc16_);
         }
         var _loc13_:uint = 0;
         if(!param3 && _content.length > 0)
         {
            if(isCompressed)
            {
               if(HAS_UNCOMPRESS || UnknownVarFromFZipFile_Boolean_1)
               {
                  _loc13_ = _content.length;
                  param1.writeBytes(_content,0,_loc13_);
               }
               else
               {
                  _loc13_ = uint(_content.length - 6);
                  param1.writeBytes(_content,2,_loc13_);
               }
            }
            else
            {
               _loc13_ = _content.length;
               param1.writeBytes(_content,0,_loc13_);
            }
         }
         var _loc12_:uint = uint(30 + _loc9_ + _loc15_ + _loc5_ + _loc13_);
         if(param3)
         {
            _loc12_ += 16;
         }
         return _loc12_;
      }
      
      internal function parse(param1:IDataInput) : Boolean
      {
         while(param1.bytesAvailable && UnknownVarFromFZipFile_Function_1(param1))
         {
         }
         return UnknownVarFromFZipFile_Function_1 === parseFileIdle;
      }
      
      protected function parseFileIdle(param1:IDataInput) : Boolean
      {
         return false;
      }
      
      protected function parseFileHead(param1:IDataInput) : Boolean
      {
         if(param1.bytesAvailable >= 30)
         {
            parseHead(param1);
            if(_sizeFilename + UnknownVarFromFZipFile_Uint_1 > 0)
            {
               UnknownVarFromFZipFile_Function_1 = parseFileHeadExt;
            }
            else
            {
               UnknownVarFromFZipFile_Function_1 = parseFileContent;
            }
            return true;
         }
         return false;
      }
      
      protected function parseFileHeadExt(param1:IDataInput) : Boolean
      {
         if(param1.bytesAvailable >= _sizeFilename + UnknownVarFromFZipFile_Uint_1)
         {
            parseHeadExt(param1);
            UnknownVarFromFZipFile_Function_1 = parseFileContent;
            return true;
         }
         return false;
      }
      
      protected function parseFileContent(param1:IDataInput) : Boolean
      {
         var _loc2_:Boolean = true;
         if(_hasDataDescriptor)
         {
            UnknownVarFromFZipFile_Function_1 = parseFileIdle;
            _loc2_ = false;
         }
         else if(_sizeCompressed == 0)
         {
            UnknownVarFromFZipFile_Function_1 = parseFileIdle;
         }
         else if(param1.bytesAvailable >= _sizeCompressed)
         {
            parseContent(param1);
            UnknownVarFromFZipFile_Function_1 = parseFileIdle;
         }
         else
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      protected function parseHead(param1:IDataInput) : void
      {
         var _loc9_:uint = uint(param1.readUnsignedShort());
         UnknownVarFromFZipFile_Int_1 = _loc9_ >> 8;
         _versionNumber = Math.floor((_loc9_ & 0xFF) / 10) + "." + (_loc9_ & 0xFF) % 10;
         var _loc4_:uint = uint(param1.readUnsignedShort());
         UnknownVarFromFZipFile_Int_2 = param1.readUnsignedShort();
         UnknownVarFromFZipFile_Boolean_2 = (_loc4_ & 1) !== 0;
         _hasDataDescriptor = (_loc4_ & 8) !== 0;
         UnknownVarFromFZipFile_Boolean_3 = (_loc4_ & 0x20) !== 0;
         if((_loc4_ & 0x0320) !== 0)
         {
            UnknownVarFromFZipFile_String_1 = "utf-8";
         }
         if(UnknownVarFromFZipFile_Int_2 === 6)
         {
            UnknownVarFromFZipFile_Int_3 = (_loc4_ & 2) !== 0 ? 8192 : 4096;
            _implodeShannonFanoTrees = (_loc4_ & 4) !== 0 ? 3 : 2;
         }
         else if(UnknownVarFromFZipFile_Int_2 === 8)
         {
            UnknownVarFromFZipFile_Int_4 = (_loc4_ & 6) >> 1;
         }
         var _loc2_:uint = uint(param1.readUnsignedShort());
         var _loc10_:uint = uint(param1.readUnsignedShort());
         var _loc3_:* = _loc2_ & 0x1F;
         var _loc5_:* = (_loc2_ & 0x07E0) >> 5;
         var _loc6_:* = (_loc2_ & 0xF800) >> 11;
         var _loc11_:* = _loc10_ & 0x1F;
         var _loc7_:* = (_loc10_ & 0x01E0) >> 5;
         var _loc8_:int = ((_loc10_ & 0xFE00) >> 9) + 1980;
         _date = new Date(_loc8_,_loc7_ - 1,_loc11_,_loc6_,_loc5_,_loc3_,0);
         _crc32 = param1.readUnsignedInt();
         _sizeCompressed = param1.readUnsignedInt();
         _sizeUncompressed = param1.readUnsignedInt();
         _sizeFilename = param1.readUnsignedShort();
         UnknownVarFromFZipFile_Uint_1 = param1.readUnsignedShort();
      }
      
      protected function parseHeadExt(param1:IDataInput) : void
      {
         var _loc5_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:ByteArray = null;
         if(UnknownVarFromFZipFile_String_1 == "utf-8")
         {
            _filename = param1.readUTFBytes(_sizeFilename);
         }
         else
         {
            _filename = param1.readMultiByte(_sizeFilename,UnknownVarFromFZipFile_String_1);
         }
         var _loc3_:uint = UnknownVarFromFZipFile_Uint_1;
         while(_loc3_ > 4)
         {
            _loc5_ = uint(param1.readUnsignedShort());
            _loc4_ = uint(param1.readUnsignedShort());
            if(_loc4_ > _loc3_)
            {
               throw new Error("Parse error in file " + _filename + ": Extra field data size too big.");
            }
            if(_loc5_ === 56026 && _loc4_ === 4)
            {
               _adler32 = param1.readUnsignedInt();
               _hasAdler32 = true;
            }
            else if(_loc4_ > 0)
            {
               _loc2_ = new ByteArray();
               param1.readBytes(_loc2_,0,_loc4_);
               UnknownVarFromFZipFile_Dictionary_1[_loc5_] = _loc2_;
            }
            _loc3_ -= _loc4_ + 4;
         }
         if(_loc3_ > 0)
         {
            param1.readBytes(new ByteArray(),0,_loc3_);
         }
      }
      
      internal function parseContent(param1:IDataInput) : void
      {
         var _loc2_:* = 0;
         if(UnknownVarFromFZipFile_Int_2 === 8 && !UnknownVarFromFZipFile_Boolean_2)
         {
            if(HAS_UNCOMPRESS || UnknownVarFromFZipFile_Boolean_1)
            {
               param1.readBytes(_content,0,_sizeCompressed);
            }
            else
            {
               if(!_hasAdler32)
               {
                  throw new Error("Adler32 checksum not found.");
               }
               _content.writeByte(120);
               _loc2_ = uint(~UnknownVarFromFZipFile_Int_4 << 6 & 0xC0);
               _loc2_ += 31 - (0x7800 | _loc2_) % 31;
               _content.writeByte(_loc2_);
               param1.readBytes(_content,2,_sizeCompressed);
               _content.position = _content.length;
               _content.writeUnsignedInt(_adler32);
            }
            isCompressed = true;
         }
         else
         {
            if(UnknownVarFromFZipFile_Int_2 != 0)
            {
               throw new Error("Compression method " + UnknownVarFromFZipFile_Int_2 + " is not supported.");
            }
            param1.readBytes(_content,0,_sizeCompressed);
            isCompressed = false;
         }
         _content.position = 0;
      }
      
      protected function compress() : void
      {
         if(!isCompressed)
         {
            if(_content.length > 0)
            {
               _content.position = 0;
               _sizeUncompressed = _content.length;
               if(UnknownVarFromFZipFile_Boolean_1)
               {
                  _content.deflate();
                  _sizeCompressed = _content.length;
               }
               else if(HAS_UNCOMPRESS)
               {
                  _content.compress.apply(_content,["deflate"]);
                  _sizeCompressed = _content.length;
               }
               else
               {
                  _content.compress();
                  _sizeCompressed = _content.length - 6;
               }
               _content.position = 0;
               isCompressed = true;
            }
            else
            {
               _sizeCompressed = 0;
               _sizeUncompressed = 0;
            }
         }
      }
      
      protected function uncompress() : void
      {
         if(isCompressed && _content.length > 0)
         {
            _content.position = 0;
            if(UnknownVarFromFZipFile_Boolean_1)
            {
               _content.inflate();
            }
            else if(HAS_UNCOMPRESS)
            {
               _content.uncompress.apply(_content,["deflate"]);
            }
            else
            {
               _content.uncompress();
            }
            _content.position = 0;
            isCompressed = false;
         }
      }
      
      public function toString() : String
      {
         return "[FZipFile]\n  name:" + _filename + "\n  date:" + _date + "\n  sizeCompressed:" + _sizeCompressed + "\n  sizeUncompressed:" + _sizeUncompressed + "\n  versionHost:" + UnknownVarFromFZipFile_Int_1 + "\n  versionNumber:" + _versionNumber + "\n  compressionMethod:" + UnknownVarFromFZipFile_Int_2 + "\n  encrypted:" + UnknownVarFromFZipFile_Boolean_2 + "\n  hasDataDescriptor:" + _hasDataDescriptor + "\n  hasCompressedPatchedData:" + UnknownVarFromFZipFile_Boolean_3 + "\n  filenameEncoding:" + UnknownVarFromFZipFile_String_1 + "\n  crc32:" + _crc32.toString(16) + "\n  adler32:" + _adler32.toString(16);
      }
   }
}

