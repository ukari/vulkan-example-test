{-# language CPP #-}
-- No documentation found for Chapter "PipelineInputAssemblyStateCreateFlags"
module Vulkan.Core10.Enums.PipelineInputAssemblyStateCreateFlags  (PipelineInputAssemblyStateCreateFlags(..)) where

import Vulkan.Internal.Utils (enumReadPrec)
import Vulkan.Internal.Utils (enumShowsPrec)
import GHC.Show (showString)
import Numeric (showHex)
import Data.Bits (Bits)
import Data.Bits (FiniteBits)
import Foreign.Storable (Storable)
import GHC.Read (Read(readPrec))
import GHC.Show (Show(showsPrec))
import Vulkan.Core10.FundamentalTypes (Flags)
import Vulkan.Zero (Zero)
-- | VkPipelineInputAssemblyStateCreateFlags - Reserved for future use
--
-- = Description
--
-- 'PipelineInputAssemblyStateCreateFlags' is a bitmask type for setting a
-- mask, but is currently reserved for future use.
--
-- = See Also
--
-- 'Vulkan.Core10.Pipeline.PipelineInputAssemblyStateCreateInfo'
newtype PipelineInputAssemblyStateCreateFlags = PipelineInputAssemblyStateCreateFlags Flags
  deriving newtype (Eq, Ord, Storable, Zero, Bits, FiniteBits)



conNamePipelineInputAssemblyStateCreateFlags :: String
conNamePipelineInputAssemblyStateCreateFlags = "PipelineInputAssemblyStateCreateFlags"

enumPrefixPipelineInputAssemblyStateCreateFlags :: String
enumPrefixPipelineInputAssemblyStateCreateFlags = ""

showTablePipelineInputAssemblyStateCreateFlags :: [(PipelineInputAssemblyStateCreateFlags, String)]
showTablePipelineInputAssemblyStateCreateFlags = []

instance Show PipelineInputAssemblyStateCreateFlags where
  showsPrec = enumShowsPrec enumPrefixPipelineInputAssemblyStateCreateFlags
                            showTablePipelineInputAssemblyStateCreateFlags
                            conNamePipelineInputAssemblyStateCreateFlags
                            (\(PipelineInputAssemblyStateCreateFlags x) -> x)
                            (\x -> showString "0x" . showHex x)

instance Read PipelineInputAssemblyStateCreateFlags where
  readPrec = enumReadPrec enumPrefixPipelineInputAssemblyStateCreateFlags
                          showTablePipelineInputAssemblyStateCreateFlags
                          conNamePipelineInputAssemblyStateCreateFlags
                          PipelineInputAssemblyStateCreateFlags

