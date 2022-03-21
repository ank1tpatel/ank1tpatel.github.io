/*

Cleaning Data in SQL Queries

*/

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing


-- Standardize Date Format
SELECT saleDateConverted, CONVERT(Date, SaleDate)
FROM PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
ADD saleDateConverted DATE;

UPDATE NashvilleHousing
SET saleDateConverted = CONVERT(Date, SaleDate)


-- Populate Property Address Data
SELECT *
FROM PortfolioProject.dbo.NashvilleHousing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]


-- Breaking out Address into Individual Columns (Address, City, State)

-- Property Address
ALTER TABLE NashvilleHousing
ADD PropertySplitAddress nvarchar(255);

ALTER TABLE NashvilleHousing
ADD PropertySplitCity nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))

-- Owner Address
ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress char(255);

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity char(255);

ALTER TABLE NashvilleHousing
ADD OwnerSplitState char(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',', '.'), 3)

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',', '.'), 2)

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',', '.'), 1)


-- Change Y and N to Yess and No in "Sold as Vacant" Field
UPDATE PortfolioProject.dbo.NashvilleHousing
SET SoldAsVacant = 'Yes'
WHERE SoldAsVacant = 'Y'

UPDATE PortfolioProject.dbo.NashvilleHousing
SET SoldAsVacant = 'No'
WHERE SoldAsVacant = 'N'


-- Remove Duplicates
SELECT ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference, COUNT(*)
FROM PortfolioProject.dbo.NashvilleHousing
GROUP BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
ORDER BY Count(*) DESC

DELETE FROM PortfolioProject.dbo.NashvilleHousing
WHERE UniqueID NOT IN (
	SELECT MAX(UniqueID)
	FROM PortfolioProject.dbo.NashvilleHousing
	GROUP BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference
	)