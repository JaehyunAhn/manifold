-- This is the Swissroll test...
require 'torch'
mani = require 'manifold'
require 'gfx.js'

local N = 2000
local K = 12
local d = 2

local tt = torch.mul(torch.add(torch.mul(torch.rand(1, N), 2), 1), (3*3.1416/2))
local height = torch.mul(torch.rand(1, N), 21)
local X = torch.DoubleTensor(3, N)
X[1] = torch.cmul(tt, torch.cos(tt))
X[2] = height
X[3] = torch.cmul(tt, torch.sin(tt))
X = X:t()

print('random embedding...')
Y = mani.embedding.random(X, {
   dim = 2,
})

gfx.chart({values=Y, key='Random'}, {chart='scatter', width=1024, height=800})

print('LLE embedding...')
Y = mani.embedding.lle(X, {
   dim = d,
   neighbors = K,
   tol = 1e-3
})

gfx.chart({values=Y, key='LLE'}, {chart='scatter', width=1024, height=800})

print('tSNE embedding...')
Y = mani.embedding.tsne(X, {
   dim = 2,
})

gfx.chart({values=Y, key='tSNE'}, {chart='scatter', width=1024, height=800})
